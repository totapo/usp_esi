require 'rails_helper'

RSpec.describe "funcionarios/new", type: :view do
  before(:each) do
    assign(:funcionario, Funcionario.new(
      :nome => "MyString",
      :cpf => "MyString",
      :email => "MyString",
      :telefone => "MyString"
    ))
  end

  it "renders new funcionario form" do
    render

    assert_select "form[action=?][method=?]", funcionarios_path, "post" do

      assert_select "input#funcionario_nome[name=?]", "funcionario[nome]"

      assert_select "input#funcionario_cpf[name=?]", "funcionario[cpf]"

      assert_select "input#funcionario_email[name=?]", "funcionario[email]"

      assert_select "input#funcionario_telefone[name=?]", "funcionario[telefone]"
    end
  end
end
