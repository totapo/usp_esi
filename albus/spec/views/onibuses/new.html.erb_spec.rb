require 'rails_helper'

RSpec.describe "onibuses/new", type: :view do
  before(:each) do
    assign(:onibus, Onibus.new(
      :placa => "MyString",
      :modelo => "MyString",
      :nAcentos => 1
    ))
  end

  it "renders new onibus form" do
    render

    assert_select "form[action=?][method=?]", onibuses_path, "post" do

      assert_select "input#onibus_placa[name=?]", "onibus[placa]"

      assert_select "input#onibus_modelo[name=?]", "onibus[modelo]"

      assert_select "input#onibus_nAcentos[name=?]", "onibus[nAcentos]"
    end
  end
end
