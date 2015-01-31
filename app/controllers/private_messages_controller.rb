class PrivateMessagesController < ApplicationController
  before_action :set_pm, only: [:show, :destroy]

  def index
    authorize PrivateMessage
    @received = current_user.received_messages.sorted
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
      notify receiver, @pm
      redirect_to private_messages_url, notice: 'Your message has been sent'
    else
      render :new, notice: 'Oops! Something happened. Please try again.'
    end
  end

  def show
  end

  def new
    @pm = PrivateMessage.new
    authorize @pm

    unless params[:reply_id].nil?
      old_pm = PrivateMessage.find(params[:reply_id])
      @pm.message = old_pm.message
        .split("\n")
        .map { |line| "> #{line}" }
        .join("\n")
      @pm.receiver = old_pm.author
    end
  end

  def destroy
    authorize @pm
    @pm.destroy
  end

protected

  def notify(user, pm)
    action = NotifyUser.new user, 'You have a new private message', pm
    action.notify
  end

  def set_pm
    @pm = PrivateMessage.find(params[:id])
  end

  def pm_params
    params.require(:private_message).permit(:message)
  end
end
