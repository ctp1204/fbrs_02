class Like < ApplicationRecord
  # belongs_to :activity
  belongs_to :user
  belongs_to :book

  scope :by_like_user, (lambda do |user_id, book_id|
    where user_id: user_id, book_id: book_id
  end)
end
