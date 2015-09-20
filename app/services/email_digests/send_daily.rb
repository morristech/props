module EmailDigests
  class SendDaily < SendBase
    private

    def subscriptions
      subscription_repo.daily
    end
  end
end
