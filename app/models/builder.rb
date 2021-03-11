class Builder < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  
  with_options presence: true do
  validates :title
  validates :description
  validates :image
  validates :category_id, numericality: { other_than: 1 } 
  end
end
