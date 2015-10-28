class PrivateMessagesController < ApplicationController
  before_action :set_pm, only: [:show, :destroy]
  before_action :check_authorization
  before_action :set_box, only: [:index, :show, :new, :destroy]
  before_action :set_messages, only: [:index, :show, :new, :create]

  def index
  end

  def create
    build_message or return render :new
    send_notification @pm
    flash[:notice] = 'Your message has been sent!'
    redirect_to private_messages_url
  end

  def show
    @reply = @pm.build_reply
  end

  def new
    receiver = fetch_receiver(params[:to])
    @pm      = PrivateMessage.new(receiver: receiver)
  end

  def destroy
    @pm.destroy_as(current_user)
    redirect_to private_messages_url(box: @box)
  end

protected

  def build_message
    @pm = PrivateMessage.new pm_params.merge(author: current_user)
    @pm.receiver = fetch_receiver(params[:private_message][:receiver]) do |error|
      flash.now[:alert] = error
      return false
    end
    @pm.save
  end

  def check_authorization
    authorize @pm || PrivateMessage
  end

  def fetch_receiver(username, &on_error)
    on_error ||= ->(error){}
    User.find_by(username: username) || on_error.call("Could not find user '#{username}'")
  end

  def set_messages
    @messages = if @box == 'sent'
      current_user.active_sent_messages.sorted
    else
      current_user.active_received_messages.sorted
    end
  end

  def send_notification(pm)
    Notification.create user: pm.receiver, message: "You have a new private message from #{pm.author.username}", notificable: pm
  end

  def set_pm
    @pm = PrivateMessage.find(params[:id])
  end

  def set_box
    @box = params[:box] || 'inbox'
  end

  def pm_params
    params.require(:private_message).permit(:message, :title)
  end
end
