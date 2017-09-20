require 'rails_helper'

RSpec.describe "funcionarios/edit", type: :view do
  before(:each) do
    @funcionario = assign(:funcionario, Funcionario.create!(
      :nome => "MyString",
      :cpf => "MyString",
      :email => "MyString",
      :telefone => "MyString"
    ))
  end

  it "renders the edit funcionario form" do
    render

    assert_select "form[action=?][method=?]", funcionario_path(@funcionario), "post" do

      assert_select "input#funcionario_nome[name=?]", "funcionario[nome]"

      assert_select "input#funcionario_cpf[name=?]", "funcionario[cpf]"

      assert_select "input#funcionario_email[name=?]", "funcionario[email]"

      assert_select "input#funcionario_telefone[name=?]", "funcionario[telefone]"
    end
  end
end
