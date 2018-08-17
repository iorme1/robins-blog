class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_save :subscribe_to_blog
  before_save  { self.role ||= :member }

  enum role: [:member, :admin]

  def subscribe_to_blog
    self.subscription = true
  end

end
