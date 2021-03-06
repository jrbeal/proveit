json.array!(@filters) do |filter|
  json.extract! filter, :id, :name, :contested_opinions, :uncontested_opinions, :contested_objections, :uncontested_objections, :comments, :initiators, :following, :active, :bookmarks, :hot_topics, :categories, :key_words, :levels, :range, :today, :last_week, :last_month
  json.url filter_url(filter, format: :json)
end
