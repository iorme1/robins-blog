class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, :as => :likeable

  mount_uploader :cover, BlogImageUploader
end
