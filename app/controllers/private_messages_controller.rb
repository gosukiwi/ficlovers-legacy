class PrivateMessagesController < ApplicationController
  def index
    authorize PrivateMessage
    @received = current_user.received_messages
  end

  def create
    @pm = PrivateMessage.new pm_params
    authorize @pm

    username = params[:private_message][:receiver]
    receiver = User.find_by(username: username)
    if receiver.nil?
      flash[:alert] = "Could not find user #{username}"
      return render :new
    end

    @pm.receiver = receiver
    @pm.author = current_user
    if @pm.save
      redirect_to private_messages_url, notice: 'Your message has been sent'
    else
      render :new, notice: 'Oops! Something happened. Please try again.'
    end
  end

  def new
    @pm = PrivateMessage.new
    authorize @pm

    unless params[:reply_id].empty?
      old_pm = PrivateMessage.find(params[:reply_id])
      @pm.message = old_pm.message
        .split("\n")
        .map { |line| "> #{line}" }
        .join("\n")
      @pm.receiver = old_pm.author
    end
  end

  def destroy
    @pm = PrivateMessage.find(params[:id])
    authorize @pm
    @pm.destroy
  end

protected

  def pm_params
    params.require(:private_message).permit(:message)
  end
end
