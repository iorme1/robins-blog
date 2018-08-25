class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  has_many :likes, :as => :likeable

  #after_create was only working part of time here for some reason...so changed to using after_commit with create option
  after_commit :send_notification, on: [:create]

  def send_notification
    comment = self.comment
    user = self.user.email.split('@')[0]
    reply = self
    post = comment.post

    if comment.user.subscription? && comment.user != reply.user
      recipient = comment.user.email
      UserMailer.reply_notification(recipient, user, reply, post).deliver_later
    end
  end
end
