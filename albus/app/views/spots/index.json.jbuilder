json.array!(@spots) do |spot|
  json.extract! spot, :latitude, :longitude, :street_number, :route, :city, :country, :postal_code
  json.url spot_url(spot, format: :json)
end
