class NotifierJob < ActiveJob::Base
  queue_as :default

  def perform(prop_id)
    Notifier.new(notification(prop_id)).call
  end

  private

  def notification(prop_id)
    prop = Prop.find(prop_id)
    NewPropNotification.new prop
  end
end
