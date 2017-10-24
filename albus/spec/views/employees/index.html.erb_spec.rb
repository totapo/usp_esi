require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  before(:each) do
    assign(:employees, [
      create(:employee),
      create(:employee)
    ])
  end

  it "renders a list of employees" do
    render
  end
end
