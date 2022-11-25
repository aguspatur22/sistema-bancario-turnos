Rails.application.routes.draw do
  #resources :clientes
  scope "/admin" do
    devise_for :usuarios, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout'}
    resources :sucursales, :usuarios, :clientes, :turnos
  end
  scope "/portal" do
    devise_for :clientes, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout'}
    resources :clientes, :turnos
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#home"
end
