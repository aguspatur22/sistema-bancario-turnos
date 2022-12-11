class ApplicationController < ActionController::Base
    add_flash_types :warning
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre, :apellido, :email, :password, :password_confirmation]) 
    end

    def current_user  #agregado para q funcione el CanCanCan
        current_usuario
    end

    def current_ability #??
        @current_ability ||= Ability.new(current_usuario, current_cliente)
    end
    
    rescue_from CanCan::AccessDenied do |exception|
        flash[:warning] = exception.message
        redirect_to root_path
    end
end
