class AddNcodeIdUniqIndexToNarous < ActiveRecord::Migration[6.1]
  def change
    add_index :narous, :ncode, unique: true
  end
end
