class UserMailer < ApplicationMailer
  default from: "robins.blogs@gmail.com"

  def post_notification(post)
    @post = post
    @users = User.all

    @users.each do |user|
      if user.subscription?
        mail to: "#{user.email}", subject: "Robin has created a new blog post"
      end
    end
  end

  def comment_notification(post, comment)
    @post = post
    @comment = comment
    @users = User.all

    @users.each do |user|
      if user.subscription?
        mail to: "#{user.email}", subject: "#{@comment.user.email} commented on Robin's blog post #{@post.title}"
      end
    end
  end
end
