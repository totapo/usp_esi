require 'rails_helper'

RSpec.describe "onibuses/show", type: :view do
  before(:each) do
    @onibus = assign(:onibus, Onibus.create!(
      :placa => "Placa",
      :modelo => "Modelo",
      :nAcentos => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Placa/)
    expect(rendered).to match(/Modelo/)
    expect(rendered).to match(/2/)
  end
end
