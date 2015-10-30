class ForumsController < ApplicationController
  before_action :set_forum, only: [:show]
  def index
    @forum = ForumFacade.new page: params[:page]
    #@forums = Forum.all
    #@posts  = Post.latest.paginate(page: params[:page], per_page: 25)
  end

  def show
    @forum = ForumFacade.new forum: @forum, page: params[:page]
    #@forums = Forum.all
    #@posts  = @forum.posts.sorted.paginate(page: params[:page], per_page: 25)
  end

  private

  def set_forum
    @forum = Forum.find(params[:id])
  end
end
