class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :visits, class_name: "Ahoy::Visit"

  default_scope { order('created_at DESC') }

  after_create :subscribe_to_blog
  before_save  { self.role ||= :member }

  enum role: [:member, :admin]

  def subscribe_to_blog
    if Rails.env.production?
      self.subscription = true
    else
      return
    end
  end

  def remember_me
    true
  end

end
