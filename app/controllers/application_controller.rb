class ApplicationController < ActionController::Base

    def current_user  #agregado para q funcione el CanCanCan
        current_usuario
    end
    
    rescue_from CanCan::AccessDenied do |exception|
        flash[:warning] = exception.message
        redirect_to root_path
    end
end
