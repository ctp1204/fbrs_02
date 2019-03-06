class Book < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.book.max_length},
   uniqueness: {case_sensitive: false}
  validates :author, presence: true, length: {maximum: Settings.book.max_length}

  delegate :name, to: :category, prefix: true, allow_nil: true
end
