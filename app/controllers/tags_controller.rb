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
    tags = Tag.search(params[:term]).limit(10).map do |tag|
      "#{tag.name} (#{tag.context})"
    end
    render json: tags, status: :ok
  end

  private

    def user_params
      params.require(:tag).permit([:name, :context])
    end
end
