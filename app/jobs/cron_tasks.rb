module CronTasks
  module EmailDigests
    class SendDailyJob
      def perform
        ::EmailDigests::SendDaily.new.call
      end
    end

    class WeeklyJob
      def perform
        ::EmailDigests::SendWeekly.new.call
      end
    end

    class CreateSubscriptionsJob
      def perform
        ::EmailDigests::CreateSubscriptions.new.call
      end
    end
  end
end
