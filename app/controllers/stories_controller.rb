class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :add_to_fav, :update_tags]
  before_action :set_category, only: [:new, :edit, :create]

  def search
    @stories = []
    @categories = Category.all
    @categories.unshift Category.new(name: 'All', id: 0)
    return unless params[:tags] || params[:category]

    # returns a list of items such as: ['tag name', 'context']
    tags = params[:tags].split(',').map do |tag|
      matches = tag.match(/^(.+?)(?:\((.+?)\))?$/).to_a
      [matches[1].strip!, matches[2]]
    end

    @stories = Story.search(tags: tags, category: params[:category])
  end
  
  # PUT /stories/1/update_tags
  #def update_tags
  #  #authorize @story
  #  if @story.set_tags(params[:tags])
  #    head :no_content
  #  else
  #    render json: 'Please try again', status: :unprocessable_entity
  #  end
  #end

  def add_to_fav
    authorize @story
    @message = @story.add_to_fav(current_user)
    respond_to do |format|
      format.js
      format.html { head :no_content }
    end
  end

  def hot
    @stories = Story.hot.limit(10)
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    authorize @story
    @story.increment_views
  end

  # GET /stories/new
  def new
    @story = Story.new
    authorize @story
    render layout: 'story_new'
  end

  def write
    @story = Story.find(params[:id])
    authorize @story
    render layout: 'story_write'
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user = current_user
    authorize @story

    if @story.save
      redirect_to write_story_path @story
    else
      render :new, layout: 'story_new'
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    @story.set_tags(params[:tags]) if params[:tags]
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :no_content, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    def set_category
      @categories = Category.all
    end      

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :user_id, :category_id, :summary, :published)
    end
end
