json.array!(@groups) do |group|
  json.extract! group, :id, :user_id, :topic_id, :group_name
  json.url group_url(group, format: :json)
end
