##userモデル(親)
json.user do
  json.partial! "api/v1/format/user", user: @user
end
