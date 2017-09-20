require 'rails_helper'

RSpec.describe "motorista/new", type: :view do
  before(:each) do
    assign(:motoristum, Motoristum.new(
      :nome => "MyString",
      :cpf => "MyString",
      :email => "MyString",
      :telefone => "MyString"
    ))
  end

  it "renders new motoristum form" do
    render

    assert_select "form[action=?][method=?]", motorista_path, "post" do

      assert_select "input#motoristum_nome[name=?]", "motoristum[nome]"

      assert_select "input#motoristum_cpf[name=?]", "motoristum[cpf]"

      assert_select "input#motoristum_email[name=?]", "motoristum[email]"

      assert_select "input#motoristum_telefone[name=?]", "motoristum[telefone]"
    end
  end
end
