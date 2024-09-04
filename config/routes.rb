Rails.application.routes.draw do
  root to: 'public/homes#top'

  scope module: :public do
    resources :users, except: [:new, :create] do
      resource :relationships, only: [:create, :destroy]
      get 'followings', to: 'relationships#followings'
      get 'followers', to: 'relationships#followers'
    end
    resources :posts, except: [:new]
    get 'posts/update_history'
    get 'search', to: 'searches#search'
    resources :comments, only: [:show, :create, :edit, :update, :destroy]
    get 'comments/:id/update_history', to: 'comments#update_history'
    resource :post_favorites, :comments_favorites, only: [:create, :destroy]
    resources :direct_messages, only: [:index, :show, :create]
    resources :messages, only: [:create, :destroy]
    get 'options'
    get 'options/user_information/edit', to: 'options#user_info_edit'
    patch 'options/user_info_update'
    get 'options/unsubscribe'
    get 'options/terms_of_service'
    get 'options/user_guide'
  end

  namespace :admin do
    get 'homes/top'
    resources :posts, only: [:index, :show, :update]
    resources :users, only: [:index, :show, :update]
    resources :comments, only: [:index, :show, :update]
  end

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "pulic/sessions"
  }

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
