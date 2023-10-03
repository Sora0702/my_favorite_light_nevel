class CreateNarouLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :narou_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :narou, null: false, foreign_key: true

      t.timestamps
    end
    add_index :narou_likes, [:user_id, :narou_id], unique: true
  end
end
