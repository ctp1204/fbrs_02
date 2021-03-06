class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true,
   length: {maximum: Settings.review.max_length}
  validates :user_id, presence: true
  validates :book_id, presence: true
end
