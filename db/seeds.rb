User.create!(name: "管理者",
              email: "admin@example.com",
              password: "333333",
              password_confirmation: "333333",
              admin: true)

10.times do |i|
  User.create!(name: "taro#{i + 1}",
              email: "taro#{i + 1}@example.com",
              password: "11111#{i + 1}",
              password_confirmation: "11111#{i + 1}"
                  )
end

10.times do |i|
  Task.create!(title: "ara#{i + 1}",
              content: "asa#{i + 1}",
              user_id: rand(1..10)
              )
end

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end
