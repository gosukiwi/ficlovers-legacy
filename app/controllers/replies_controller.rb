class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update, :destroy]

  def create
    @reply = Reply.new reply_params
    authorize @reply

    @post = Post.find(params[:post_id])
    @reply.user = current_user
    @reply.post = @post

    if @reply.save
      notify_users @post
      redirect_to [@post.forum, @post], notice: 'Reply was successfully created.'
    else
      redirect_to [@post.forum, @post], alert: @reply.errors.full_messages.to_sentence
    end
  end

  def edit
    authorize @reply
  end

  def update
    authorize @reply
    if @reply.update(reply_params)
      redirect_to [@reply.post.forum, @reply.post], notice: 'Post was successfully created.'
    else
      render :edit
    end
  end

  def destroy
    authorize @reply
    @reply.delete
  end

  private

    def notify_users(post)
      return unless post.watchers.any?

      message = "#{current_user.username} replied to the post #{view_context.link_to(post.title, [post.forum, post])}"
      post.watchers.each do |user|
        NotifyUser.new(user, message).notify
      end
    end

    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content)
    end
end
