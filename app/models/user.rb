class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  attr_accessor :login

  has_one_attached :avatar
  has_many :posts
  has_many :comments

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.strip.downcase }]).first
  end
end
