class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :set_story

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.story = @story
    authorize @chapter

    if @chapter.save
      # return the saved object so Backbone can assign the 'id' property to 
      # the model
      render json: @chapter, status: :ok, location: [@story, @chapter]
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @chapter
    if @chapter.update(chapter_params)
      head :no_content, location: [@story, @chapter]
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @chapter
    @chapter.destroy
    head :no_content
  end

  private
    # Override of default pundit's exception catch
    def user_not_authorized
      render json: 'You are not authorized to perform this action.', status: :unauthorized
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    def set_story
      @story = Story.find(params[:story_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :story_id, :content, :order)
    end
end
