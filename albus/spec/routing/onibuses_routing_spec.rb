require "rails_helper"

RSpec.describe OnibusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/onibuses").to route_to("onibuses#index")
    end

    it "routes to #new" do
      expect(:get => "/onibuses/new").to route_to("onibuses#new")
    end

    it "routes to #show" do
      expect(:get => "/onibuses/1").to route_to("onibuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/onibuses/1/edit").to route_to("onibuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/onibuses").to route_to("onibuses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/onibuses/1").to route_to("onibuses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/onibuses/1").to route_to("onibuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/onibuses/1").to route_to("onibuses#destroy", :id => "1")
    end

  end
end
