json.shelter(@shelters) do |shelter|
  json.extract! shelter, :name, :introduce, :lonlat
  json.url shelter_url(shelter, format: :json)
end
