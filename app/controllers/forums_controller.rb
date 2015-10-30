class ForumsController < ApplicationController
  before_action :set_forum, only: [:show]
  def index
    @forum = ForumFacade.new page: params[:page]
  end

  def show
    @forum = ForumFacade.new forum: @forum, page: params[:page]
  end

  private

  def set_forum
    @forum = Forum.find(params[:id])
  end
end
