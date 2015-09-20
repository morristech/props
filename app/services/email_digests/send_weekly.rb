module EmailDigests
  class SendWeekly < SendBase
    private

    def subscriptions
      subscription_repo.weekly
    end
  end
end
