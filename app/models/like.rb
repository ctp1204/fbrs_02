class Like < ApplicationRecord
  # belongs_to :activity
  belongs_to :user
  belongs_to :book
end
