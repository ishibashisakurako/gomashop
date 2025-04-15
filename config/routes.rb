Rails.application.routes.draw do
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  
  # ①Deviseのルーティングを先に書く
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :customers, only: [:show, :edit, :update]
  end

  root to: "public/homes#top"
end
