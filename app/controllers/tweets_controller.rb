class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = current_user.following.map{|a| a.tweets}.flatten
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  def add_like
    @tweet = Tweet.find(params[:id])
    puts params[:type][:type]
    if params[:type][:type] == 'add'
      @tweet.likes.create(liked_by: current_user.id)
    else
      @tweet.likes.where(liked_by: current_user.id).all.destroy_all
    end
    @tweets = Tweet.all
    render partial: 'users/tweets_list', locals: {tweets: @tweets}
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save!
        format.html { redirect_to users_path(current_user), notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { redirect_to users_path(current_user) }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:type, :message, :user_id, :tweet_id, :attachable, :picture, attachments_attributes: [:id, :picture, :_destroy])
    end
end
