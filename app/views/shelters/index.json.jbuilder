json.shelters(@shelters) do |shelter|
 json.Shelter do |json|
  json.extract! shelter, :id, :name, :introduce, :kind ,:lonlat, :created_at, :updated_at
  json.url shelter_url(shelter, format: :json)
 end
end
