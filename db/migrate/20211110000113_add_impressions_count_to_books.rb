class AddImpressionsCountToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :impression_count, :integer
  end
end
