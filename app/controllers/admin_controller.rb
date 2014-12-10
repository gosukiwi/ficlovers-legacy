class AdminController < ApplicationController
  def index
    authorize Admin.new
  end

  def tags
    @tags = Tag.pending_tags
  end
end
