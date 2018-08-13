class UserMailer < ApplicationMailer
  default to: -> { User.where(subscription: true).pluck(:email) },
          from: 'robins-blog.herokuapp.com'

  def post_notification(post)
    @post = post
    mail(subject: "Robin has created a new blog post")
  end

  def comment_notification(post, comment)
    @post = post
    @comment = comment
    mail(subject: "#{@comment.user.email} commented on Robin's blog post #{@post.title}")
  end
end
