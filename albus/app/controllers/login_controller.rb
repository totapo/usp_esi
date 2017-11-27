class LoginController < ApplicationController

  def new
  end

  def create
    @employee = Employee.find_by(email: employee_params['email'], password: employee_params['password'])
    respond_to do |format|
      if @employee
        session[:user_id] = @employee.id
        format.html { redirect_to employees_path }
      else
        format.html { redirect_to new_login_url, notice: 'E-mail ou senha incorretos!' }
      end
    end
  end

  def logout
    reset_session
    redirect_to new_login_path
  end

  def employee_params
    params.permit(:email, :password)
  end

end
