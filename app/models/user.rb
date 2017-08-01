class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :timeoutable

  extend FriendlyId
  friendly_id :email, use: :slugged

  has_and_belongs_to_many :roles

  validates :email, presence: true
  validates :password, presence: true
end
