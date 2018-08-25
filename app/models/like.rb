class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :likeable, polymorphic: true

	after_create :send_notification


	def send_notification
		if self.likeable_type == "Post"
			send_like_post_notification
		elsif self.likeable_type == "Comment"
			#send_like_comment_notification
		elsif self.likeable_type = "Reply"
			#send reply_like_notification 
		end
	end


	private

	def send_like_post_notification
		post = self.likeable
		user = self.user.email

		if Rails.env.production?
			recipients = User.where(role: "admin").pluck(:email)
			recipients.each do |recipient|
				UserMailer.like_post_notification(user, post, recipient).deliver_later
			end
		else
			UserMailer.like_post_notification(user, post, "isorme1@gmail.com").deliver_later
		end
	end

end
