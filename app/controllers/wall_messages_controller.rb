class WallMessagesController < ApplicationController
  def create
    message = WallMessage.new message_params
    authorize message

    receiver = User.find_by username: params[:user_username]
    message.receiver = receiver
    message.author   = current_user

    if message.save
      redirect_to receiver
    else
      redirect_to receiver, notice: 'Please specify a message'
    end
  end

protected

  def message_params
      params.require(:wall_message).permit([:content])
  end
end
