class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,   presence:true
  validates :profile,presence:true
  validates :history,presence:true

  has_many :builders
  has_many :comments, dependent: :destroy
end
