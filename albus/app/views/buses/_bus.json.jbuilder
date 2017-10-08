json.extract! bus, :id, :plate, :model, :nSeats, :created_at, :updated_at
json.url bus_url(bus, format: :json)
