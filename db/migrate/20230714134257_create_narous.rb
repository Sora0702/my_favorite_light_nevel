class CreateNarous < ActiveRecord::Migration[6.1]
  def change
    create_table :narous do |t|
      t.string :title
      t.string :writer
      t.integer :biggenre
      t.string :ncode
      t.text :story

      t.timestamps
    end
  end
end
