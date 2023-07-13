class RenameAutherToColumnNovels < ActiveRecord::Migration[6.1]
  def change
    rename_column :novels, :auther, :author
  end
end
