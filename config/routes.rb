KanbanBoard::Application.routes.draw do

    resources :kanbans
    resources :tasks, except: [:index, :show]

    scope ":username" do
        get '/show', to: 'users#show', as: 'user_name'
        get '/edit', to: 'users#edit', as: 'user_name_edit'
    end

    match '/sign_in_guest', to: "application#create_guest_user", via: 'get'

    resources :users
    resources :sessions, only: [:new, :create, :destroy]

    root "static_pages#home"

    match '/signup', to: 'users#new',             via: 'get'
    match '/signin',  to: 'sessions#new',         via: 'get'
    match '/signout', to: 'sessions#destroy',     via: 'delete'

    match '/makekanban', to: "kanbans#default", via: 'get'
    match '/about', to: "static_pages#about", via: 'get'

end
