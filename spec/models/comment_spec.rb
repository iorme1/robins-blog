require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(email: "isaac@example.com", password: "123123") }
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body 20 Characters", user: user) }
  let(:comment) { Comment.create!(body: "Comment Body", post: post, user: user ) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
