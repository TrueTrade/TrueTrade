json.array!(@test_usernames) do |test_username|
  json.extract! test_username, :id, :name, :description, :picture
  json.url test_username_url(test_username, format: :json)
end
