class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update]

  def create
    @reply = Reply.new reply_params
    authorize @reply
    @post = Post.find(params[:post_id])
    @reply.user = current_user
    @reply.post = @post
    if @reply.save
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

  private

    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content)
    end
end
