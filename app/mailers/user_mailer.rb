class UserMailer < ApplicationMailer
  def eventCreationMailer(event)
    @event = event
    mail(to: @event.user.email, subject: "Congratulations! Event is created successfully")
  end
end
