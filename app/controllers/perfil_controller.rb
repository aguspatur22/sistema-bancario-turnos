class PerfilController < ApplicationController

    def perfil_cliente
        if current_cliente
            @usuario = current_cliente
            render 'cliente'
        else
            redirect_to new_cliente_session_path
        end
    end

    def perfil_usuario
        if current_usuario
            @usuario = current_usuario
            render 'usuario'
        else
            redirect_to new_usuario_session_path
        end
    end


    # POST
    def password
        if current_usuario
            @usuario = current_usuario
        else
            redirect_to new_usuario_session_path
        end
    end


    # POST
    def change_password
        if usuario_signed_in?
            if current_usuario.update_with_password(usuario_params)
                sign_in(current_usuario, :bypass => true)
                respond_to do |format|
                    format.html { redirect_to "/admin/perfil", notice: "Se actualizo la contraseña correctamente" }
                end
            else
                respond_to do |format|
                    format.html { redirect_to "/admin/password", alert: "Hubo un error en el cambio de contraseña. Intente nuevamente" }
                end
            end
        else
            redirect_to new_usuario_session_path
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def usuario_params
        params.require(:usuario).permit(:password, :password_confirmation, :current_password)
    end

    def cliente_params
        params.require(:cliente).permit(:password, :password_confirmation)
    end

end