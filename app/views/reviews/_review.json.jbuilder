json.extract! review, :id, :rating, :comment
json.url review_url(review, format: :json)
