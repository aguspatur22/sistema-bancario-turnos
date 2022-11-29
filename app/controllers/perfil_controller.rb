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
            @usuario = current_cliente
        end
    end


    # POST
    def change_password
        puts "==================="
        puts params
        puts "==================="
        if usuario_signed_in?
            if current_usuario.update_with_password(params[:password])
                flash[:notice] = "Updated Password Successfully"
            else
                flash[:error] = "There was an error updating your password, please try again."
            end
        else
            redirect_to new_usuario_session_path
        end
        if cliente_signed_in?
            if current_cliente.update_with_password(params[:password])
                flash[:notice] = "Updated Password Successfully"
            else
                flash[:error] = "There was an error updating your password, please try again."
            end
        else
            redirect_to new_cliente_session_path #??
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def usuario_params
        params.require(:usuario).permit(:password, :password_confirmation)
    end

    def cliente_params
        params.require(:cliente).permit(:password, :password_confirmation)
    end

end