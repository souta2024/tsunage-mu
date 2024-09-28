Rails.application.routes.draw do
  namespace :public do
    get 'homes/top'
  end
  namespace :admin do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  root to: 'public/homes#top'

  scope module: :public do
    get 'timeline', to: 'posts#timeline'
    get 'posts/drafts'
    get 'posts/draft/:id/edit', to: 'posts#edit_draft', as: 'edit_post_draft'
    get 'posts/draft/:id', to: 'posts#show_draft', as: 'post_draft'
    patch 'posts/draft/:id', to: 'posts#update_draft'
    resources :posts, except: [:new] do
      post 'favorite', to: 'post_favorites#create'
      delete 'favorite', to: 'post_favorites#destroy'
      get 'update_history'
    end

    get 'search', to: 'searches#search'

    resources :comments, only: [:show, :create, :edit, :update, :destroy] do
      post 'favorite', to: 'comment_favorites#create'
      delete 'favorite', to: 'comment_favorites#destroy'
      get 'update_history'
    end

    resources :direct_messages, only: [:index, :show, :create]

    scope '/:account_id' do
      get 'edit', to: 'users#edit', as: 'edit_user'
      get '', to: 'users#show', as: 'user'
      patch '', to: 'users#update', as: 'user_patch', param: :account_id
      put '', to: 'users#update', as: 'user_put', param: :account_id
      delete '', to: 'users#destroy', as: 'user_delete', param: :account_id
      resource :relationships, only: [:create, :destroy]
      get 'followings', to: 'relationships#followings'
      get 'followers', to: 'relationships#followers'
    end
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :update] do
      get 'update_history'
    end
    resources :users, only: [:index]
    resources :comments, only: [:index, :show, :update]
    get 'search', to: 'searches#search'

    scope '/:account_id' do
      get 'edit', to: 'users#edit', as: 'edit_user'
      get '', to: 'users#show', as: 'user'
      patch '', to: 'users#update', as: 'user_patch'
      put '', to: 'users#update', as: 'user_put'
      get 'followings', to: 'relationships#followings'
      get 'followers', to: 'relationships#followers'
    end
  end

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
