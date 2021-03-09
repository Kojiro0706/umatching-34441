class Builder < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  
  validates :title,presence:true
  validates :description,presence:true
  validates :image, presence: true
  validates :category_id, numericality: { other_than: 1 } 
end
