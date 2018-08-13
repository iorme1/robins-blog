require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "post_notification" do
    mail = UserMailer.post_notification
    assert_equal "Post notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
