class Admin::TagsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Admin::Tag.new
    @tags = Tag.pending_tags
  end

  def approve
    authorize Admin::Tag.new
    @tag = Tag.find(params[:id])
    @tag.status = 'active'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end

  def deny
    authorize Admin::Tag.new
    @tag = Tag.find(params[:id])
    @tag.status = 'removed'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end
end
