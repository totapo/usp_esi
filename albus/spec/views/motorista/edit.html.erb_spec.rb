require 'rails_helper'

RSpec.describe "motorista/edit", type: :view do
  before(:each) do
    @motoristum = assign(:motoristum, Motoristum.create!(
      :nome => "MyString",
      :cpf => "MyString",
      :email => "MyString",
      :telefone => "MyString"
    ))
  end

  it "renders the edit motoristum form" do
    render

    assert_select "form[action=?][method=?]", motoristum_path(@motoristum), "post" do

      assert_select "input#motoristum_nome[name=?]", "motoristum[nome]"

      assert_select "input#motoristum_cpf[name=?]", "motoristum[cpf]"

      assert_select "input#motoristum_email[name=?]", "motoristum[email]"

      assert_select "input#motoristum_telefone[name=?]", "motoristum[telefone]"
    end
  end
end
