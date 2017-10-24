require 'rails_helper'

RSpec.describe "buses/show", type: :view do
  before(:each) do
    @bus = create(:bus)#assign(:bus, Bus.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
