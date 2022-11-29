class ApplicationController < ActionController::Base
    add_flash_types :warning
    
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
