json.shelter(@shelters) do |shelter|
  json.extract! shelter,:id, :name, :introduce, :lonlat, :created_at, :updated_at
  json.url shelter_url(shelter, format: :json)
end
