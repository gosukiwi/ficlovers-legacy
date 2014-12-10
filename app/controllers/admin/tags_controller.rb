class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.pending_tags
  end

  def approve
    tag = Tag.find(params[:id])
    tag.status = 'active'
    if tag.save
      head :no_content
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  def deny
    tag = Tag.find(params[:id])
    tag.status = 'removed'
    if tag.save
      head :no_content
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end
end
