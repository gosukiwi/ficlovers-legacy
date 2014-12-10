class Admin::TagsController < Admin::AdminController
  def index
    # we use :: so we don't end up using the Admin::Tag model
    @tags = ::Tag.pending_tags
  end

  def approve
    authorize Tag.new
    @tag = ::Tag.find(params[:id])
    @tag.status = 'active'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end

  def deny
    authorize Tag.new
    @tag = ::Tag.find(params[:id])
    @tag.status = 'removed'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end
end
