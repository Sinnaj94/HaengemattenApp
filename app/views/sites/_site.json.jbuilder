json.extract! site, :id, :name, :description
json.user do
	json.first site.user.first_name
	json.last site.user.last_name
end
json.position do
    json.lon site.longitude.to_f
    json.lat site.latitude.to_f
end
json.belongs_to_user site.user == current_user
json.review_count site.reviews.size
json.meanrating site.meanrating
json.sizes site.sizes do |size|
	json.id size.id
	json.name size.name
end
if site.user == current_user
	json.edit edit_site_path(site, format: :json)
end
json.url site_url(site, format: :json)
