json.array!(@shelters) do |shelter|
  json.extract! shelter, :id, :name, :introduce, :lonlat
  json.url shelter_url(shelter, format: :json)
end
