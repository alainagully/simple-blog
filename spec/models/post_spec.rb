require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do
    
    it "requires a title" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a minimum title length of 7" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    
    it "requires a body" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:body)
    end
  end

  describe ".body_snippet" do
    it "should return a string that is at most 100 characters long" do
      b = ''
      200.times{b << 'abc'}
      p = Post.new(title: 'abcdefgh', body: b)
      expect(p.body_snippet.length).to eq(100)
    end
  end
    
end
