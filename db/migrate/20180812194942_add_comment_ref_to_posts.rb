class AddCommentRefToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :comment, foreign_key: true
  end
end
