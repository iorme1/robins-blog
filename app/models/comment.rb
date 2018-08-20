class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, :as => :likeable
  has_many :replies 
end
