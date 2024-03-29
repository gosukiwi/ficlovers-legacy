class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :add_to_fav, :settings, :thumb_crop, :thumb_save, :epub]
  before_action :set_categories, only: [:new, :edit, :create, :search]

  def epub
    path = GenerateEpub.new(story: @story, url: story_url(@story)).generate
    send_file path, type: 'application/epub'
  end

  def thumb_save
    #authorize @story
    begin
      form = ThumbCropForm.new params
      FinishThumb.new(form, @story).finish
      redirect_to settings_story_url(@story), notice: "Fic image updated."
    rescue ActionError => e
      @errors = e.errors
      render :settings
    end
  end

  # POST /stories/1/crop
  # Temporary uploads a file and display the crop menu
  def thumb_crop
    #authorize @story
    begin
      form = ThumbUploadForm.new params
      @image = PrepareThumb.new(form).prepare
    rescue ActionError => e
      @errors = e.errors
      render :settings
    end
  end

  # GET /stories/1/settings 
  # settings page
  def settings
    #authorize @story
  end

  def search
    @categories = [Category.new(name: 'Any', id: 0)] + @categories
    @stories    = StorySearch
      .search(search_params)
      .paginate(page: params[:page], per_page: 10)
  end
  
  def add_to_fav
    authorize @story
    @message = @story.add_to_fav(current_user)
  end

  def fresh
    @stories = Story.fresh.paginate(page: params[:page], per_page: 10)
  end

  def hot
    @stories = Story.hot.limit(10)
  end

  def feed
    authorize current_user
    @stories = StoryFeed.new(current_user).generate.paginate(page: params[:page], per_page: 10)
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
      render :new
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

  def search_params
    params.permit(:tags, :category, :language, :order).symbolize_keys
  end

  def set_story
    @story = Story.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end      

  # Never trust parameters from the scary internet, only allow the white list through.
  def story_params
    params.require(:story).permit(:title, :user_id, :category_id, :summary, :published, :language)
  end
end
