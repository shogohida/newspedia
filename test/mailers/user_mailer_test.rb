require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    mail = UserMailer.welcome
    assert_equal "Welcome", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end


# class UserMailerPreview < ActionMailer::Preview
#   def welcome
#     user = User.first
#     # This is how you pass value to params[:user] inside mailer definition!
#     UserMailer.with(user: user).welcome
#   end
# end
