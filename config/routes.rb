Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments, except: [:index, :edit, :update]
  end
  get 'posts/index'
  root 'posts#index'

  get '*path' => redirect('/')
end
