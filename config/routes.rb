Rails.application.routes.draw do

  scope "/portal" do
    devise_for :clientes, path: 'auth', path_names: { sign_in: 'login'}
    resources :clientes, :turnos
  end
  
  scope "/admin" do
    devise_for :usuarios, path: 'auth', path_names: { sign_in: 'login'}
    resources :sucursales, :usuarios, :clientes, :turnos
    get '/perfil', to: 'usuarios#perfil'
  end

  # Defines the root path route ("/")
  root "main#home"
end
