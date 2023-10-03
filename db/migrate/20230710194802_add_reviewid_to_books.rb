class AddReviewidToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :review_id, :integer
  end
end
