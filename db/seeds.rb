User.create!(name: "管理者",
              email: "admin@example.com",
              password: "333333",
              password_confirmation: "333333",
              admin: true)

# 50.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                 email: email,
#                 password_digest: password,
#                 )
# end