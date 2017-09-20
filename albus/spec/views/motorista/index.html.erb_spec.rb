require 'rails_helper'

RSpec.describe "motorista/index", type: :view do
  before(:each) do
    assign(:motorista, [
      Motoristum.create!(
        :nome => "Nome",
        :cpf => "Cpf",
        :email => "Email",
        :telefone => "Telefone"
      ),
      Motoristum.create!(
        :nome => "Nome",
        :cpf => "Cpf",
        :email => "Email",
        :telefone => "Telefone"
      )
    ])
  end

  it "renders a list of motorista" do
    render
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Cpf".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Telefone".to_s, :count => 2
  end
end
