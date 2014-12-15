class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_forum

  def show
    authorize @post
    @replies = @post.paginated_replies(params[:page])
  end

  def new
    authorize @post
    @post = Post.new
  end

  def create
    authorize @post
    @post = Post.new post_params
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
