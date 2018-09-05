require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(email: "isaac@example.com", password: "123123") }
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body Over 20 Characters", user: user) }


  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body Over 20 Characters")
    end
  end
end
