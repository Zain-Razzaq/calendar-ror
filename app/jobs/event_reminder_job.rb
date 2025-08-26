class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return if event.nil?

    UserMailer.eventReminderMailer(event).deliver_later
  end
end
