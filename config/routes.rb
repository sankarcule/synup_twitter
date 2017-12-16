Rails.application.routes.draw do
  resources :tweets do
    member do
      post :add_like
      post :reply_tweet
    end
  end
  devise_for :users
  resources :users do
    member do
      get :followers
      get :following
    end
    collection do
      get :follow
      get :unfollow
      get :retweet
    end
  end
  root 'tweets#index'
end
