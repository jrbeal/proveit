json.array!(@accounts) do |account|
  json.extract! account, :id, :user_id, :user_name, :first_name, :last_name, :email, :timezone, :language, :password, :verbosity, :default_filter, :list, :location, :occupation, :phone, :education, :about, :opinions, :comments, :initiators, :offspring, :rating, :percentile
  json.url account_url(account, format: :json)
end
