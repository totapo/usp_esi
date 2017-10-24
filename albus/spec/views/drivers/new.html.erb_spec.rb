require 'rails_helper'

RSpec.describe "drivers/new", type: :view do
  before(:each) do
    @driver = build(:driver)
  end

  it "renders new driver form" do
    render

    assert_select "form[action=?][method=?]", drivers_path, "post" do
    end
  end
end
