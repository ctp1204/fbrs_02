module BooksHelper
  def cats
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def load_categories
    Category.sort_by_name
  end
end
