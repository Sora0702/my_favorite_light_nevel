class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.string :novel_name
      t.string :category
      t.string :auther
      t.text :impression

      t.timestamps
    end
  end
end
