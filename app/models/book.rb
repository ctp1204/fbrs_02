class Book < ApplicationRecord
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
  scope :by_category,
    ->(category_id){where category_id: category_id if category_id.present?}

  has_attached_file :book_img, styles:
   {book_index: Settings.book_index, book_show: Settings.book_show},
   default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: %r{\Aimage\/.*\z}
  validates :title, presence: true, length: {maximum: Settings.book.max_length},
   uniqueness: {case_sensitive: false}
  validates :author, presence: true, length: {maximum: Settings.book.max_length}
  delegate :name, to: :category, prefix: true, allow_nil: true
end
