class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_forum

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.forum = @forum
    if(@post.save)
      redirect_to [@forum, @post], notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
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
