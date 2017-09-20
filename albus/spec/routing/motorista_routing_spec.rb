require "rails_helper"

RSpec.describe MotoristaController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/motorista").to route_to("motorista#index")
    end

    it "routes to #new" do
      expect(:get => "/motorista/new").to route_to("motorista#new")
    end

    it "routes to #show" do
      expect(:get => "/motorista/1").to route_to("motorista#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/motorista/1/edit").to route_to("motorista#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/motorista").to route_to("motorista#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/motorista/1").to route_to("motorista#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/motorista/1").to route_to("motorista#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/motorista/1").to route_to("motorista#destroy", :id => "1")
    end

  end
end
