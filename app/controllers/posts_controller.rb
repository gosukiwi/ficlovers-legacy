class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :pin]
  before_action :set_forum

  layout 'forums'

  def show
    authorize @post
    @post = @post.decorate
    @post.increment_views
    @forums = Forum.all
    @replies = @post.paginated_replies(params[:page])
    @new_reply = Reply.new
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new post_params
    authorize @post
    @post.forum = @forum
    @post.user = current_user
    if(@post.save)
      redirect_to [@forum, @post], notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to [@forum, @post], notice: 'Post was successfully created.'
    else
      render :edit
    end
  end

  def pin
    @success = @post.toggle! :pinned
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def set_forum
      @forum = Forum.find(params[:forum_id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
