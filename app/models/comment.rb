class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  delegate :name, to: :user, prefix: :user, allow_nil: true

  validates :content, presence: true,
   length: {maximum: Settings.comment.max_length}
end
