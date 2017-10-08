json.extract! employee, :id, :name, :cpf, :email, :telephone, :created_at, :updated_at
json.url employee_url(employee, format: :json)
