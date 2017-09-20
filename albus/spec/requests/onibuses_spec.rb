require 'rails_helper'

RSpec.describe "Onibuses", type: :request do
  describe "GET /onibuses" do
    it "works! (now write some real specs)" do
      get onibuses_path
      expect(response).to have_http_status(200)
    end
  end
end
