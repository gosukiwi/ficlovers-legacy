class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :pin, :watch]
  before_action :set_forum

  layout 'forums'

  def watch
    authorize @post
    @result = current_user.watch_toggle @post
  end

  def show
    authorize @post
    @post.increment_views
    @replies = @post.replies.sorted.paginate(page: params[:page], per_page: 10)
    @forums = Forum.all
    @new_reply = Reply.new
  end

  def new
    @post = Post.new forum: @forum
    authorize @post
  end

  def create
    @post = Post.new post_params
    authorize @post
    @post.user = current_user
    if @post.save
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
      params.require(:post).permit(:title, :content).merge(forum: @forum)
    end
end
