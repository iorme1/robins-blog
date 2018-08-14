class UserMailer < ApplicationMailer
  default to: -> { User.where(subscription: true).pluck(:email) },
          from: 'robins-blog.herokuapp.com'

  def post_notification(post)
    return if User.where(subscription: true).pluck(:email).empty?
    @post = post
    mail(subject: "Robin has created a new blog post")
  end

  def comment_notification(post, comment)
    return if User.where(subscription: true).pluck(:email).empty?
    @post = post
    @comment = comment
    mail(subject: "#{@comment.user.email} commented on Robin's blog post #{@post.title}")
  end
end
