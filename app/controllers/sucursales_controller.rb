class SucursalesController < ApplicationController
  before_action :set_sucursal, only: %i[ show edit update destroy ]
  before_action :authenticate_usuario!
  load_and_authorize_resource :except => [:create, :update]

  # GET /sucursales or /sucursales.json
  def index
    @sucursales = Sucursal.all
  end

  # GET /sucursales/1 or /sucursales/1.json
  def show 
  end

  # GET /sucursales/new
  def new
    @sucursal = Sucursal.new
  end

  # GET /sucursales/1/edit
  def edit
  end

  def create_dia(id,ini,fin)
    d = Dia.new()
    d.dia = id
    d.inicio = ini.to_i
    d.fin = fin.to_i
    d
  end

  # POST /sucursales or /sucursales.json
  def create
    data = sucursal_params()
    puts params
    # @sucursal = Sucursal.new()

    # #primero creo los dias
    # lunes = create_dia(1,data[:ini1],data[:fin1])
    # martes = create_dia(2,data[:ini2],data[:fin2])
    # miercoles = create_dia(3,data[:ini3],data[:fin3])
    # jueves = create_dia(4,data[:ini4],data[:fin4])
    # viernes = create_dia(5,data[:ini5],data[:fin5])
    # @sucursal.dias << lunes
    # @sucursal.dias << martes
    # @sucursal.dias << miercoles
    # @sucursal.dias << jueves
    # @sucursal.dias << viernes

    # @sucursal.nombre = data[:nombre]
    # @sucursal.direccion = data[:direccion]
    # @sucursal.telefono = data[:telefono]

    # respond_to do |format|
    #   if @sucursal.save
    #     format.html { redirect_to sucursal_url(@sucursal), notice: "Sucursal was successfully created." }
    #     format.json { render :show, status: :created, location: @sucursal }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @sucursal.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  def update_dia(dia,ini,fin)
    dia.inicio = ini.to_i
    dia.fin = fin.to_i
    dia.save!
  end


  # PATCH/PUT /sucursales/1 or /sucursales/1.json
  def update
    data = sucursal_params()

    #primero creo los dias
    update_dia(@sucursal.dias[0],data[:ini1],data[:fin1])
    update_dia(@sucursal.dias[1],data[:ini2],data[:fin2])
    update_dia(@sucursal.dias[2],data[:ini3],data[:fin3])
    update_dia(@sucursal.dias[3],data[:ini4],data[:fin4])
    update_dia(@sucursal.dias[4],data[:ini5],data[:fin5])

    respond_to do |format|
      if @sucursal.update(nombre: data[:nombre], direccion: data[:direccion], telefono: data[:telefono])
        format.html { redirect_to sucursal_url(@sucursal), notice: "Sucursal was successfully updated." }
        format.json { render :show, status: :ok, location: @sucursal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sucursales/1 or /sucursales/1.json
  def destroy

    if Turno.where(sucursal_id: @sucursal.id, estado: "pendiente").empty?
      @sucursal.destroy
      respond_to do |format|
        format.html { redirect_to sucursales_url, notice: "Sucursal was successfully destroyed." }
      end
    else
      respond_to do |format|
        format.html { redirect_to sucursal_url(@sucursal), alert: "No se pudo eliminar la sucursal debido a que posee turnos pendientes" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sucursal
      @sucursal = Sucursal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sucursal_params
      params.require(:sucursal).permit(:nombre, :direccion, :telefono, 
      :ini1, :fin1,
      :ini2, :fin2,
      :ini3, :fin3,
      :ini4, :fin4,
      :ini5, :fin5)
    end
end
