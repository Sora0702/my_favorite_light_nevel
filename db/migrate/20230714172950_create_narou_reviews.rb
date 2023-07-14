class CreateNarouReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :narou_reviews do |t|
      t.text :content
      t.integer :user_id
      t.integer :narou_id

      t.timestamps
    end
  end
end
