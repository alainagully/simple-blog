class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX },
            unless: :from_omniauth?

  def self.find_from_omniauth(omniauth_data)
    User.where(provider: omniauth_data["provider"],
               uid:      omniauth_data["uid"]).first
  end

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(uid: omniauth_data["uid"],
                provider: omniauth_data["provider"],
                first_name: full_name[0],
                last_name: full_name[1],
                password: SecureRandom.urlsafe_base64)
  end
  
  private

  def from_omniauth?
    uid.present? && provider.present?
  end
end
