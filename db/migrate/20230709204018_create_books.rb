class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.bigint :isbn
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
