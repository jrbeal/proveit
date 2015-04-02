json.array!(@topics) do |topic|
  json.extract! topic, :id, :topic_id, :private, :lone_wolf, :teams, :public_viewing, :public_comments, :post_id
  json.url topic_url(topic, format: :json)
end
