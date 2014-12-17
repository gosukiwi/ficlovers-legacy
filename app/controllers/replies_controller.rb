class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = Reply.new reply_params
    authorize @reply
    @reply.user = current_user
    @reply.post = @post
    if @reply.save
      redirect_to [@post.forum, @post], notice: 'Reply was successfully created.'
    else
      redirect_to [@post.forum, @post], alert: @reply.errors.full_messages.to_sentence
    end
  end

  private

    def reply_params
      params.require(:reply).permit(:content)
    end
end
