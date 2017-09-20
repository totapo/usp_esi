require 'rails_helper'

RSpec.describe "onibuses/index", type: :view do
  before(:each) do
    assign(:onibuses, [
      Onibus.create!(
        :placa => "Placa",
        :modelo => "Modelo",
        :nAcentos => 2
      ),
      Onibus.create!(
        :placa => "Placa",
        :modelo => "Modelo",
        :nAcentos => 2
      )
    ])
  end

  it "renders a list of onibuses" do
    render
    assert_select "tr>td", :text => "Placa".to_s, :count => 2
    assert_select "tr>td", :text => "Modelo".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
