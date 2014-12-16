class ForumsController < ApplicationController
  layout 'forums'

  def index
    @forums = Forum.all
  end

  def show
    @forums = Forum.all
    @forum = Forum.find(params[:id])
  end
end
