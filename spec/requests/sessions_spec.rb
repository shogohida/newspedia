require 'rails_helper'

# need to review the syntax
RSpec.describe "Sessions" do
  it "signs user in and out" do
    user = FactoryBot.build(:user) ## uncomment if using FactoryBot
    # user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
    sign_in user
    get root_path
    expect(response).to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.

    sign_out user
    get root_path
    expect(response).not_to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.
  end
end
