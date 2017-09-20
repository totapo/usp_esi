require "rails_helper"

RSpec.describe FuncionariosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/funcionarios").to route_to("funcionarios#index")
    end

    it "routes to #new" do
      expect(:get => "/funcionarios/new").to route_to("funcionarios#new")
    end

    it "routes to #show" do
      expect(:get => "/funcionarios/1").to route_to("funcionarios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/funcionarios/1/edit").to route_to("funcionarios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/funcionarios").to route_to("funcionarios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/funcionarios/1").to route_to("funcionarios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/funcionarios/1").to route_to("funcionarios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/funcionarios/1").to route_to("funcionarios#destroy", :id => "1")
    end

  end
end
