require 'rails_helper'

RSpec.describe "Funcionarios", type: :request do
  describe "GET /funcionarios" do
    it "works! (now write some real specs)" do
      get funcionarios_path
      expect(response).to have_http_status(200)
    end
  end
end
