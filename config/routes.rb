Rails.application.routes.draw do
  root to: 'public/homes#top'

  scope module: :public do
    resources :users, only: [:index]

    get 'timeline', to: 'posts#timeline'
    get 'posts/draft'
    get 'posts/draft/:id/edit', to: 'posts#edit_draft', as: 'edit_post_draft'
    patch 'posts/draft/:id', to: 'posts#update_draft', as: 'update_post_draft'
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
    resources :messages, only: [:create, :destroy]

    get 'options', to: 'options#option'
    get 'options/user_information/edit', to: 'options#user_info_edit'
    patch 'options/user_info_update'
    get 'options/unsubscribe'
    get 'options/terms_of_service'
    get 'options/user_guide'

    scope '/:account_id' do
      get 'edit', to: 'users#edit', as: 'edit_user'
      get '', to: 'users#show', as: 'user'
      patch '', to: 'users#update', as: 'user_patch'
      put '', to: 'users#update', as: 'user_put'
      delete '', to: 'users#destroy', as: 'user_delete'
      resource :relationships, only: [:create, :destroy]
      get 'followings', to: 'relationships#followings'
      get 'followers', to: 'relationships#followers'
    end
  end

  namespace :admin do
    get 'homes/top'
    resources :posts, only: [:index, :show, :update]
    resources :users, only: [:index, :show, :update]
    resources :comments, only: [:index, :show, :update]
  end

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
