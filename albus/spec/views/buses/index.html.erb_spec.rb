require 'rails_helper'

RSpec.describe "buses/index", type: :view do
  before(:each) do
    assign(:buses, [
      create(:bus),
      create(:bus)
    ])
  end

  it "renders a list of buses" do
    render
  end
end
