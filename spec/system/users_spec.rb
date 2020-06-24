require 'rails_helper'

RSpec.describe User, type: :system do
  it "is valid if they have a name, email and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid if they don't have a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid if they don't have an email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid if their email is the same as another" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user)
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "is invalid if they don't have a password" do
    user = FactoryBot.build(:user, password: nil)
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
