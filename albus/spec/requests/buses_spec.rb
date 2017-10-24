require 'rails_helper'

RSpec.describe "Buses", type: :request do

  describe "GET /buses" do
    it "should redirect to bus list page" do
       get buses_path
       expect(response).to render_template(:index)
     end
  end

  describe "GET /buses/new" do
   it "should redirect to new bus page" do
     get new_bus_path
     expect(response).to render_template(:new)
   end
  end

  describe "POST /buses" do
     it "should create a new bus" do
       expect{
         post buses_path, params: {bus: {plate:"ARP-1234", model: "test_model", nSeats: "40" }}
       }.to change{Bus.count}.by 1
       expect(response).to redirect_to buses_path
     end

     it "should not create a new bus" do
       expect{
         post buses_path, params: {bus: {plate:"ARP-1234", model: "test_model"}}
       }.to change{Bus.count}.by 0
       expect(response).to render_template(:new)
     end

  end

  describe "GET /buses/id" do
    it "should redirect do show bus page" do
      bus = create(:bus)
      get buses_path+"/"+bus.id.to_s
      expect(response).to render_template(:show)
    end
  end

  describe "GET /buses/id/edit" do
   it "should successfully access edit bus page" do
      get edit_bus_path create(:bus)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /buses/id" do
    let(:attr) do
      { :model => 'new model', :plate => 'new plate', :nSeats=>20 }
    end

    let(:attrF) do
      { :model => 'new model', :plate => 'new plate'}
    end

    it "should successfully update bus" do
      bus = create(:bus)
      put buses_path+'/'+bus.id.to_s, params: {bus: attr}
      bus.reload

      expect(bus.model).to eql attr[:model]
      expect(bus.plate).to eql attr[:plate]
      expect(bus.nSeats).to eql attr[:nSeats]
      expect(response).to redirect_to buses_path+"/"+bus.id.to_s
    end

    it "should not update bus" do
      bus = create(:bus)
      bus.id=-1
      put buses_path+'/'+bus.id.to_s, params: {bus: attrF}

      expect(response).to redirect_to buses_path
    end
  end

  describe "DELETE /buses/id" do
    it "should successfully destroy bus" do
       bus = create(:bus)
       expect{
         delete buses_path+'/'+bus.id.to_s, params:{id: bus.id}
       }.to change{Bus.count}.by -1
       expect(response).to redirect_to buses_path
     end
  end

end
