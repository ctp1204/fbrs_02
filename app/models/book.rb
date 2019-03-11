class Book < ApplicationRecord
  belongs_to :category

  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :order_book, ->{order created_at: :desc}
  scope :active, -> category_id {where category_id: category_id}

  has_attached_file :book_img, styles:
   {book_index: Settings.book_index, book_show: Settings.book_show},
   default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: %r{/\Aimage\/.*\z/}

  validates :title, presence: true, length: {maximum: Settings.book.max_length},
   uniqueness: {case_sensitive: false}
  validates :author, presence: true, length: {maximum: Settings.book.max_length}

  delegate :name, to: :category, prefix: true, allow_nil: true
end
