module Typeable
extend ActiveSupport::Concern

  def set_new_book
    @book = Book.new
  end

end