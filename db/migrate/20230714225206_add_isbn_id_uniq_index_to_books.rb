class AddIsbnIdUniqIndexToBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :books, :isbn, unique: true
  end
end
