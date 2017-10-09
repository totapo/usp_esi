class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /funcionarios
  # GET /funcionarios.json
  def index
    @employees = Employee.all
  end

  # GET /funcionarios/1
  # GET /funcionarios/1.json
  def show
  end

  # GET /funcionarios/new
  def new
    @employee = Employee.new
  end

  # GET /funcionarios/1/edit
  def edit
  end

  # POST /funcionarios
  # POST /funcionarios.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_url, notice: 'Funcionário foi criado com sucesso!' }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funcionarios/1
  # PATCH/PUT /funcionarios/1.json
  def update
    respond_to do |format|
      if @employee.update(funcionario_params)
        format.html { redirect_to @employee, notice: 'Funcionario was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Funcionario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:password, :name, :cpf, :email, :telephone)
    end
end
