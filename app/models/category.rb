class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  scope :sort_by_name, ->{order :name}
end
