Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do 
    namespace :v1 do
      resources :games, only: [:index, :create, :show] do
        resources :moves, only: [:create]
        resources :flags, only: [:create]
      end
    end
  end

  resources :games, only: [:index, :create, :show]

  root to: 'games#index'
end

#THIS IS ONLY FOR TESTING GITHUB APP

#Lorem Ipsum is simply dummy text of the printing and typesetting industry.
#Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
#when an unknown printer took a galley of type and scrambled it to make a type specimen book.
#It has survived not only five centuries, but also the leap into electronic typesetting,
#remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset
#sheets containing Lorem Ipsum passages, and more recently with desktop publishing software
#like Aldus PageMaker including versions of Lorem Ipsum