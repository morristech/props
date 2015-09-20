module EmailDigests
  class SendBase
    def call
      Rails.logger.tagged('Email Digest') do |logger|
        logger.info "Found #{subscriptions.count} subscriptions to process " \
          "in #{self.class}"
        subscriptions.each do |sub|
          digest = EmailDigest.new(since_timestamp: sub.last_sent_at,
                                   user: sub.user)
          process_digest(digest, sub, logger)
        end
      end
    end

    private

    def process_digest(digest, subscription, logger)
      if digest.props_received.any?
        logger.info "Sending email to #{digest.user.email}"
        send_email(digest)
        subscription.touch(:last_sent_at)
      else
        logger.info "Not sending email to #{digest.user.email} "\
          " - no received props after #{subscription.last_sent_at}"
      end
    end

    def send_email(digest)
      PropsDigest.received(digest.user, digest.props_received).deliver_later
    end

    def subscriptions
      raise 'override me'
    end

    def subscription_repo
      @subscription_repo ||= MailSubscriptionsRepository.new
    end
  end
end
