require 'rails_helper'

RSpec.describe "onibuses/edit", type: :view do
  before(:each) do
    @onibus = assign(:onibus, Onibus.create!(
      :placa => "MyString",
      :modelo => "MyString",
      :nAcentos => 1
    ))
  end

  it "renders the edit onibus form" do
    render

    assert_select "form[action=?][method=?]", onibus_path(@onibus), "post" do

      assert_select "input#onibus_placa[name=?]", "onibus[placa]"

      assert_select "input#onibus_modelo[name=?]", "onibus[modelo]"

      assert_select "input#onibus_nAcentos[name=?]", "onibus[nAcentos]"
    end
  end
end
