require 'rails_helper'

RSpec.describe User, type: :system do
  it "a user is valid if they have a name, email and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "a user is invalid if they don't have a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "a user id invalid if they don't have an email"  do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "a user is invalid if their email is the same as another" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user)
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "a user is invalid if they don't have a password" do
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end

# RSpec.describe 'Users', type: :system do
#   before do
#     @user = User.create!(name: '')
#   end

#   it 'completes yubinbango automatically with JS' do
#     # User編集画面を開く
#     visit edit_user_path(@user)

#     # Nameに"いとう"が入力されていることを検証する
#     expect(page).to have_field '名前', with: 'いとう'

#     # 郵便番号を入力
#     fill_in '郵便番号', with: '158-0083'
#     # 住所が自動入力されたことを検証する
#     expect(page).to have_field '住所', with: '東京都世田谷区奥沢'

#     # 更新実行
#     click_button 'Update User'

#     # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
#     expect(page).to have_content 'User was successfully updated.'
#     expect(page).to have_content 'いとう'
#     expect(page).to have_content '158-0083'
#     expect(page).to have_content '東京都世田谷区奥沢'
#   end
# end


# require 'rails_helper'

# RSpec.describe User, type: :model do

#   it "姓、名、メール、パスワードがある場合、有効である" do
# 　　 # userのそれぞれのカラムに対して値を入れてオブジェクト化する
#     user = User.new(
#     first_name: "tarou",
#      last_name: "testman",
#      email: "testman@example.com",
#      password: "password",
#      )
#      # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
#      expect(user).to be_valid
#   end

#   it "名がない場合、無効である"
#   it "姓がない場合、無効である"
#   it "メールアドレスがない場合、無効である"
#   it "重複したメールアドレスの場合、無効である"
# 　it "パスワードがない場合、無効である"

# end
