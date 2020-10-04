Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :games, only: [:index, :create, :show] do
    resources :moves, only: [:create] do
      collection do
        post '/flag' => 'moves#flag'
      end
    end
  end
end
