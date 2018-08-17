class UserMailer < ApplicationMailer
  default from: 'robins-blog.herokuapp.com'

  def post_notification(recipient, post)
    return if User.where(subscription: true).pluck(:email).empty?
    @post = post
    mail(to: recipient, subject: "Robin has created a new blog post")
  end

  def comment_notification(post, comment)
    @post = post
    @comment = comment
    mail(to: "jrorme1@sbcglobal.net", subject: "#{@comment.user.email} commented on Robin's blog post #{@post.title}")
  end
end
