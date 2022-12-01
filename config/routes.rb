Rails.application.routes.draw do

  scope "/portal" do
    devise_for :clientes, path: 'auth', path_names: { sign_in: 'login'}
    get '/turnos', to: 'turnos#index_cliente'
    resources :turnos, :except => :index
    get '/perfil', to: 'perfil#perfil_cliente'
  end
  
  scope "/admin" do
    devise_for :usuarios, path: 'auth', path_names: { sign_in: 'login'}
    resources :sucursales, :usuarios, :clientes

    get '/turnos', to: 'turnos#index_personal'
    get '/turnos/:id', to: 'turnos#show'
    get '/turnos/:id/edit', to: 'turnos#atender_turno'
    put '/turnos/:id', to: 'turnos#atender'
    patch '/turnos/:id', to: 'turnos#atender', :as => :atender_turno
    #lo hace, pero primero me redirige al home pq hace tambn la consulta al portal

    get '/perfil', to: 'perfil#perfil_usuario'
    get '/password', to: 'perfil#password'
    put '/password', to: 'perfil#change_password'
    patch '/password', to: 'perfil#change_password'
  end

  # Defines the root path route ("/")
  root "main#home"
end
