class UserMailer < ApplicationMailer
  def eventCreationMailer(event)
    @event = event
    mail(to: @event.user.email, subject: "Congratulations! Event is created successfully")
  end

  def eventReminderMailer(event)
    @event = event
    mail(
      to: @event.user.email,
      subject: "Reminder: Your event '#{@event.title}' starts soon!"
    )
  end
end
