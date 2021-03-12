class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '雑談' },
    { id: 3, name: 'マッチング' },
    { id: 4, name: '競馬予想' }
  ]
  include ActiveHash::Associations
  has_many :builders
end