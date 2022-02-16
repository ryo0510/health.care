Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:show, :edit, :update]
    resources :courses, except: [:destroy]
    resources :categories, only: [:index, :create, :edit, :update]
  end

  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    root to: "homes#top"
    get 'homes/about' => 'homes#about'

    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customers_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    get 'customers/mypage' => 'customers#show'
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/update' => 'customers#update'

    resources :post_messages, only: [:index, :create] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :courses, only: [:index, :show] do
      collection do
        get 'search'
      end
    end
    resources :entries, only: [:new, :create, :index]
    resources :course_results, only: [:show] do
      resources :histories, only: [:create, :destroy]
    end
  end
end
