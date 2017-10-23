require 'rails_helper'

RSpec.describe "buses/new", type: :view do
  before(:each) do
    assign(:bus, Bus.new())
  end

  it "renders new bus form" do
    render

    assert_select "form[action=?][method=?]", buses_path, "post" do
    end
  end
end
