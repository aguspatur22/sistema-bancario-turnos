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

    @sucursal = Sucursal.new()

    #primero creo los dias
    dias = ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]
    dias.each_with_index do |x,y|
      @sucursal.dias << create_dia(y+1,data[x.to_sym][:ini],data[x.to_sym][:fin])
    end

    @sucursal.nombre = data[:nombre]
    @sucursal.direccion = data[:direccion]
    @sucursal.telefono = data[:telefono]

    respond_to do |format|
      if @sucursal.save
        format.html { redirect_to sucursal_url(@sucursal), notice: "Sucursal eliminada correctamente" }
        format.json { render :show, status: :created, location: @sucursal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end


  def update_dia(num,ini,fin)
    d = @sucursal.dias.find_by(dia: num)
    d.update(inicio: ini.to_i, fin: fin.to_i)
  end


  # PATCH/PUT /sucursales/1 or /sucursales/1.json
  def update
    data = sucursal_params()

    #primero updateo los dias
    dias = ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]

    dias.each_with_index do |x,y|
      update_dia(y+1,data[x.to_sym][:ini],data[x.to_sym][:fin])
    end

    respond_to do |format|
      if @sucursal.update(nombre: data[:nombre], direccion: data[:direccion], telefono: data[:telefono])
        format.html { redirect_to sucursal_url(@sucursal), notice: "Sucursal actualizada correctamente" }
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
        format.html { redirect_to sucursales_url, notice: "Sucursal eliminada correctamente" }
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
      :Lunes =>{}, :Martes =>{}, :Miercoles =>{}, :Jueves =>{}, :Viernes =>{}, :Sabado =>{}, :Domingo =>{})
    end
end
