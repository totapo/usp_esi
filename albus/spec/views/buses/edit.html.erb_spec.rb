require 'rails_helper'

RSpec.describe "buses/edit", type: :view do
  before(:each) do
    @bus = assign(:bus, Bus.create!())
  end

  it "renders the edit bus form" do
    render

    assert_select "form[action=?][method=?]", bus_path(@bus), "post" do
    end
  end
end
