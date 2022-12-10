class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[ show edit update destroy ]
  before_action :authenticate_usuario! 
  load_and_authorize_resource :except => [:create, :update]


  # GET /usuarios or /usuarios.json
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1 or /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end


  # POST /usuarios or /usuarios.json
  def create
    data = usuario_params()
    @usuario = Usuario.new()
    @usuario.email = data[:email]
    @usuario.password = data[:password]
    @usuario.password_confirmation = data[:password_confirmation]
    if (data[:rol] == '1')
      @usuario.add_role :personal
      suc = Sucursal.find_by(nombre: data[:sucursal])
      @usuario.sucursal = suc
    else
      @usuario.add_role :admin
    end
    @usuario.save!
    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuario_url(@usuario), notice: "Usuario creado exitosamente." }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1 or /usuarios/1.json
  def update

    data = usuario_params()

    if (data[:rol] == '1')
      if (!@usuario.has_role? :personal) #personal y antes era admin
        if Sucursal.where(usuario_id: nil).empty? #quiero ser personal pero no hay sucursales
          respond_to do |format|
            format.html { redirect_to usuarios_url, alert: "No hay sucursales disponibles para asignar" }
          end
          return
        end 
        
        @usuario.remove_role :admin
        @usuario.add_role :personal
        @usuario.sucursal = Sucursal.find_by(nombre: data[:sucursal])

      elsif (@usuario.sucursal.nombre != data[:sucursal]) #personal y antes era personal
        @usuario.sucursal = nil
        @usuario.sucursal = Sucursal.find_by(nombre: data[:sucursal])
      end

    else
      @usuario.remove_role :personal
      @usuario.add_role :admin
      @usuario.sucursal = nil
    end

    respond_to do |format|
      if @usuario.update_attribute(:email, data[:email])
        if (current_usuario.id == @usuario.id) #para el caso q modifique mi usuario, necesito volver a loguearme
          sign_out current_usuario
          redirect_to destroy_usuario_session_path and return
        end
        format.html { redirect_to usuario_url(@usuario), notice: "Usuario actualizado exitosamente" }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1 or /usuarios/1.json
  def destroy
    if @usuario.sucursal
      @usuario.sucursal.update(usuario_id: nil)
    end
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: "Usuario eliminado exitosamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuario_params
      params.require(:usuario).permit(:email, :password, :password_confirmation, :rol, :sucursal)
    end
end
