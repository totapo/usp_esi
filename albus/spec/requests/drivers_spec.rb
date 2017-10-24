require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  describe "GET /drivers" do
    it "should redirect to drivers list page" do
       get drivers_path
       expect(response).to render_template(:index)
     end
  end

  describe "GET /driver/new" do
   it "should redirect to new driver page" do
     get new_driver_path
     expect(response).to render_template(:new)
   end
  end

  describe "POST /drivers" do
     it "should create a new driver" do
       expect{
         post drivers_path, params: {driver: {name:"name", email: "email", cpf: "40", telephone:"1234" }}
       }.to change{Driver.count}.by 1
       expect(response).to redirect_to drivers_path
     end

     it "should not create a new driver" do
       expect{
         post drivers_path, params: {driver: {email: "email", cpf: "40", telephone:"1234" }}
       }.to change{Driver.count}.by 0
       expect(response).to render_template(:new)
     end

  end

  describe "GET /drivers/id" do
    it "should redirect do show driver page" do
      driver = create(:driver)
      get drivers_path+"/"+driver.id.to_s
      expect(response).to render_template(:show)
    end
  end

  describe "GET /drivers/id/edit" do
   it "should successfully access edit driver page" do
      get edit_driver_path create(:driver)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /drivers/id" do
    let(:attr) do
      { :name => 'new name', :email => 'new email', :cpf=>"0987890",:telephone=>"09877890" }
    end

    it "should successfully update driver" do
      driver = create(:driver)
      put drivers_path+'/'+driver.id.to_s, params: {driver: attr}
      driver.reload

      expect(driver.name).to eql attr[:name]
      expect(driver.email).to eql attr[:email]
      expect(driver.telephone).to eql attr[:telephone]
      expect(driver.cpf).to eql attr[:cpf]
      expect(response).to redirect_to drivers_path+"/"+driver.id.to_s
    end

    it "should not update driver" do
      driver = create(:driver)
      driver.id=-1
      put drivers_path+'/'+driver.id.to_s, params: {driver: attr}

      expect(response).to redirect_to drivers_path
    end
  end

  describe "DELETE /drivers/id" do
    it "should successfully destroy driver" do
       driver = create(:driver)
       expect{
         delete drivers_path+'/'+driver.id.to_s, params:{id: driver.id}
       }.to change{Driver.count}.by -1
       expect(response).to redirect_to drivers_path
     end
  end
end
