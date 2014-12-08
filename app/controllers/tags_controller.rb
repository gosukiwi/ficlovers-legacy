class TagsController < ApplicationController
  def create
    tag = Tag.new(user_params)
    story = Story.find(params[:story_id])
    story.tags << tag

    if tag.save
      head :no_content
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  def search
    tags = Tag.search(params[:context], params[:term]).pluck(:name)
    render json: tags, status: :ok, only: [:name, :context]
  end

  private

    def user_params
      params.require(:tag).permit([:name, :context])
    end
end
