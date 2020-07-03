FactoryBot.define do
  # Userモデルのテストデータを定義
  factory :user, class: User do
    name { 'User' }
    email { 'user@gmail.com' }
    password { '123456' }
  end

  # not necessary?
  # factory :shogo, class: User do
  #   name { 'Shogo' }
  #   email { 'shogo@gmail.com' }
  #   password { '123456' }
  # end

  # factory :julien, class: User do
  #   name { 'Julien' }
  #   email { 'julien@gmail.com' }
  #   password { '123456' }
  # end

  # factory :yun, class: User do
  #   name { 'Yun' }
  #   email { 'yun@gmal.com' }
  #   password { '123456' }
  # end
end
