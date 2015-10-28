class PrivateMessagesController < ApplicationController
  before_action :set_pm, only: [:show, :destroy]
  before_action :check_authorization
  before_action :set_box
  before_action :set_messages

  def index
  end

  def create
    create_message or return render :new
    send_notification
    flash[:notice] = 'Your message has been sent!'
    redirect_to private_messages_url
  end

  def show
    @reply = @pm.build_reply
  end

  def new
    receiver = User.find_by(username: params[:to])
    @pm      = PrivateMessage.new(receiver: receiver)
  end

  def destroy
    @pm.destroy_as(current_user)
    redirect_to private_messages_url(box: @box)
  end

protected

  def create_message
    receiver = User.find_by(username: pm_params[:receiver])
    @pm = PrivateMessage.new pm_params.merge(author: current_user, receiver: receiver)
    @pm.save
  end

  def check_authorization
    authorize @pm || PrivateMessage
  end

  def set_messages
    @messages = if @box == 'sent'
      current_user.active_sent_messages.sorted
    else
      current_user.active_received_messages.sorted
    end
  end

  def send_notification
    Notification.create user: @pm.receiver, message: "You have a new private message from #{@pm.author.username}", notificable: @pm
  end

  def set_pm
    @pm = PrivateMessage.find(params[:id])
  end

  def set_box
    @box = params[:box] || 'inbox'
  end

  def pm_params
    params.require(:private_message).permit(:message, :title, :receiver)
  end
end
