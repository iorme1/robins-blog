class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, :as => :likeable

  after_commit :send_post_notification, on: [:create, :update], :if => :notify_of_post?
  mount_uploader :cover, BlogImageUploader

  def send_post_notification
    recipients = User.where(subscription: true).pluck(:email)
    post = self
    recipients.each do |recipient|
      UserMailer.post_notification(recipient, post).deliver_later
    end
  end

  def notify_of_post?
    self.notify?
  end

end
