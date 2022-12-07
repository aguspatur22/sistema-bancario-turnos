class TurnosController < ApplicationController
  before_action :set_turno, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /turnos or /turnos.json
  def index_cliente
    if current_cliente
      @turnos = Turno.where(cliente_id: current_cliente.id)
      render 'index'
    else
      redirect_to new_cliente_session_path
    end
  end

  # GET /turnos or /turnos.json
  def index_personal
    if current_usuario and current_usuario.has_role? :personal
      idSuc = current_usuario.sucursal.id
      @turnos = Turno.where(sucursal_id: idSuc, estado: 'pendiente')  #solo muestro pendientes
      render 'index'    #una vez q los atiendo ya no me aparecen mas a mi como personal, pero al cliente si!!
    else
      redirect_to :root
    end
  end

  # GET /turnos/1 or /turnos/1.json
  def show
  end

  # GET /turnos/new
  def new
    @turno = Turno.new
  end

  # POST /turnos/get_horas
  def get_horarios
    @sucursal = Sucursal.find_by(id: params[:idS]).dias
    render json: @sucursal
  end

  # GET /turnos/1/edit
  def edit
  end

  # POST /turnos or /turnos.json    
  def create

    data = turno_params()

    anio,mes,dia = data[:dia].split("-").map {|x| x.to_i}
    
    fecha = DateTime.new(anio,mes,dia,data[:hora].to_i,data[:minutos].to_i)

    @turno = Turno.new()
    @turno.estado = "pendiente"
    @turno.motivo = data[:motivo]
    @turno.fecha = fecha
    @turno.sucursal_id = Sucursal.find_by(id: data[:sucursal_id].to_i).id
    @turno.cliente_id = current_cliente.id

    respond_to do |format|     #chequeo de segunda condicion para el caso q ya tiene un turno en esa suc ese dia
      if current_cliente.turnos.where(sucursal_id: data[:sucursal_id].to_i).any? {|x| x.fecha.strftime("%Y-%m-%d") == data[:dia]}
        format.html { redirect_to turnos_url, alert: "Usted ya posee un turno ese dia en esa sucursal" }
      elsif @turno.save
        format.html { redirect_to turno_url(@turno), notice: "Turno creado exitosamente" }
        format.json { render :show, status: :created, location: @turno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turnos/1 or /turnos/1.json
  def update 
    data = turno_params()         #chequeo de fecha

    respond_to do |format|
      if @turno.update(motivo: data[:motivo], sucursal_id: data[:sucursal_id], fecha: data[:fecha])
        format.html { redirect_to turno_url(@turno), notice: "Turno was successfully updated." }
        format.json { render :show, status: :ok, location: @turno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turno.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /turnos/1/edit
  def atender_turno
    render 'atender'
  end

  # PATCH/PUT /turnos/1 or /turnos/1.json
  def atender 
    data = turno_params()

    respond_to do |format|
      if @turno.update(resultado: data[:resultado], usuario_id: current_usuario.id, estado: "atendido")
        format.html { redirect_to '/admin/turnos', notice: "Turno atendido exitosamente" }
        format.json { render :show, status: :ok, location: @turno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turno.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /turnos/1 or /turnos/1.json
  def destroy
    if (@turno.estado == 'pendiente') #no puede eliminar turnos ya atendidos, solo pendientes
      @turno.destroy
      respond_to do |format|
        format.html { redirect_to turnos_url, notice: "Turno was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to turnos_url, alert: "El turno no se puede eliminar porque ya esta atendido" }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turno
      @turno = Turno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turno_params
      params.require(:turno).permit(:dia, :hora, :minutos, :motivo, :resultado, :sucursal_id)
    end
end
