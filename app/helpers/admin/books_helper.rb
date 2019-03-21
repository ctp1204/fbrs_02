module Admin::BooksHelper
  def load_categories_for_selectbox
    @categories = Category.all.map{|c| [c.name, c.id]}
  end
end
