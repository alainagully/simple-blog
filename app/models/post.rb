class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_length_of :title, minimum: 7

  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy
  belongs_to :category
  belongs_to :user

  def body_snippet
    body.length > 100 ? body[0..96] << '...' : body
  end

end
