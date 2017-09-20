require 'rails_helper'

RSpec.describe "motorista/show", type: :view do
  before(:each) do
    @motoristum = assign(:motoristum, Motoristum.create!(
      :nome => "Nome",
      :cpf => "Cpf",
      :email => "Email",
      :telefone => "Telefone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Cpf/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Telefone/)
  end
end
