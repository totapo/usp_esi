require 'rails_helper'

RSpec.describe "Employees", type: :request do
  describe "GET /employees" do
    it "should redirect to drivers list page" do
       get employees_path
       expect(response).to render_template(:index)
     end
  end

  describe "GET /employees/new" do
   it "should redirect to new driver page" do
     get new_employee_path
     expect(response).to render_template(:new)
   end
  end

  describe "POST /employees" do
     it "should create a new employee" do
       expect{
         post employees_path, params: {employee: {name:"name", email: "email", cpf: "40", telephone:"1234", password:"12345" }}
       }.to change{Employee.count}.by 1
       expect(response).to redirect_to employees_path
     end

     it "should not create a new employee" do
       expect{
         post employees_path, params: {employee: {email: "email", cpf: "40", telephone:"1234" }}
       }.to change{Employee.count}.by 0
       expect(response).to render_template(:new)
     end

  end

  describe "GET /employees/id" do
    it "should redirect do show employee page" do
      employee = create(:employee)
      get employees_path+"/"+employee.id.to_s
      expect(response).to render_template(:show)
    end
  end

  describe "GET /employees/id/edit" do
   it "should successfully access edit employee page" do
      get edit_employee_path create(:employee)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /employees/id" do
    let(:attr) do
      { :name => 'new name', :email => 'new email', :cpf=>"0987890",:telephone=>"09877890",:password=>"123456" }
    end

    it "should successfully update employee" do
      employee = create(:employee)
      put employees_path+'/'+employee.id.to_s, params: {employee: attr}
      employee.reload

      expect(employee.name).to eql attr[:name]
      expect(employee.email).to eql attr[:email]
      expect(employee.telephone).to eql attr[:telephone]
      expect(employee.cpf).to eql attr[:cpf]
      expect(employee.password).to eql attr[:password]
      expect(response).to redirect_to employees_path+"/"+employee.id.to_s
    end

    it "should not update employee" do
      employee = create(:employee)
      employee.id=-1
      put employees_path+'/'+employee.id.to_s, params: {employee: attr}

      expect(response).to redirect_to employees_path
    end
  end

  describe "DELETE /employees/id" do
    it "should successfully destroy employee" do
       employee = create(:employee)
       expect{
         delete employees_path+'/'+employee.id.to_s, params:{id: employee.id}
       }.to change{Employee.count}.by -1
       expect(response).to redirect_to employees_path
     end
  end
end
