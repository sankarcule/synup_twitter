class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followers, :following]

  # GET /Users
  # GET /Users.json
  def index
    @users = User.all
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
    @tweet = Tweet.new
    @tweets = @user.tweets.all
  end

  # GET /Users/new
  def new
    @user = User.new
  end

  # GET /Users/1/edit
  def edit
  end

  def followers
    @user = User.find()
    @tweet = Tweet.new
  end

  def following
    @tweet = Tweet.new
  end

  def follow
    Relationship.create!(following_id: params[:id][:id], follower_id: current_user.id)
    redirect_to users_path
  end

  def unfollow
    Relationship.where(following_id: params[:id][:id], follower_id: current_user.id).destroy_all
    redirect_to users_path
  end

  def retweet
    @tweet = Tweet.find(params[:id][:id])
    Tweet.create(message: @tweet.message, user_id: current_user.id)
    redirect_to users_path(current_user.id)
  end

  # POST /Users
  # POST /Users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:name, :age, :gender, :profile_pic, attachments_attributes: [:id, :picture, :_destroy])
    end
end
