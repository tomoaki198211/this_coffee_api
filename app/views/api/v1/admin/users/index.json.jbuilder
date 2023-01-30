##userモデル(親)
json.array! @users do |user|
  json.partial! "api/v1/format/user", user: user
end
