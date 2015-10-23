class ForumsController < ApplicationController
  def index
    @forums = Forum.all
    @posts = Post.latest.paginate(page: params[:page], per_page: 25)
  end

  def show
    @forums = Forum.all
    @forum = Forum.find(params[:id])
    @posts = @forum.posts.sorted.paginate(page: params[:page], per_page: 25)
  end
end
