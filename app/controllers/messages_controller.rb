class MessagesController < ApplicationController
  before_action :require_user

  def index
    @messages = Message.recent
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      message_data = {
        id: @message.id,
        content: @message.content,
        user_name: @message.user.name,
        created_at: @message.created_at.strftime("%H:%M")
      }
      ActionCable.server.broadcast("messages", message_data)
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
