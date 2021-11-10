class RemoveImpressionCountFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :impression_count, :integer
  end
end
