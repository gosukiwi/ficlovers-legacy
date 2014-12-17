class ForumsController < ApplicationController
  layout 'forums'

  def index
    @forums = Forum.all
    # show latest posts
    @posts = Post.order('id DESC').paginate(page: params[:page], per_page: 25)
  end

  def show
    @forums = Forum.all
    @forum = Forum.find(params[:id])
    @posts = @forum.formatted_posts.paginate(page: params[:page], per_page: 25)
  end
end
