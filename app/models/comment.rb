class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :builder

  validates :text,presence: true
end
