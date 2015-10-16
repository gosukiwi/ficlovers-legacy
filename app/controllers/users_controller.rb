class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :edit, :update, :about, :fics, :favs, :feed]
  before_action :check_logged, only: [:edit]
  after_action :verify_authorized, except: [:index, :new, :create]

  def follow
    authorize @user
    @result = FollowUser.new(current_user, @user).follow
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
    @stories = @user.stories.fresh.limit(6)
    @favs = @user.favorites.fresh.limit(6)
    @wall_message = WallMessage.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  def about
    authorize @user

    if @user.update about: params[:about]
      render :edit, notice: 'User information saved'
    else
      render :edit
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'Congratulations! Your account has been created. Please log in.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user

    if @user.update(user_params)
      render :edit, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def fics
    authorize @user
    @fics = @user.stories.fresh.paginate(page: params[:page], per_page: 12)
  end

  def favs
    authorize @user
    @favs = @user.favorites.fresh.paginate(page: params[:page], per_page: 12)
  end

  def feed
    authorize @user
    @feed = StoryFeed.new(current_user).generate.paginate(page: params[:page], per_page: 12)
  end

  def search
    authorize User
    wildcard_username = "%#{params[:term]}%"
    render json: User.where('username LIKE :username', username: wildcard_username).pluck('username')
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #def destroy
  #  @user.destroy
  #  respond_to do |format|
  #    format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(username: params[:username])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit([:name, :email, :username, :password, :password_confirmation])
    end

    def check_logged
      redirect_to login_path unless logged_in?
    end
end
