FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'サンプル' }
    email { 'sample@sample.com' }
    password { '111111' }
    password_confirmation { '111111' }
    admin { false }
  end
  factory :second_user, class: User do
    id { 2 }
    name { '太郎' }
    email { 'taro@sample.com' }
    password { '222222' }
    password_confirmation { '222222' }
    admin { true }
  end
end
