class Admin::TagsController < Admin::AdminController
  def index
    @tags = Tag.pending
  end

  def approve
    @tag = Tag.find(params[:id])
    @tag.context = params[:as]
    @tag.status = 'active'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end

  def deny
    @tag = Tag.find(params[:id])
    @tag.status = 'removed'
    @success = @tag.save

    respond_to do |format|
      format.js
      format.html { redirect_to :admin_tags }
    end
  end
end
