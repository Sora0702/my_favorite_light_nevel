class AddColumnToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :user_id, :integer
  end
end
