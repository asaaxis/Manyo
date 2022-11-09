# User.create!(name: "管理者",
#               email: "admin@example.com",
#               password: "333333",
#               password_confirmation: "333333",
#               admin: true)


# User.create!(name: "taro",
#                 email: "taro@example.com",
#                 password: "111111",
#                 password_confirmation: "111111",
#                 )

5.times do |i|
  Label.create!(name: "sample#{i + 1}")
end
