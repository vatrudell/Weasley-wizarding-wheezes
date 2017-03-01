class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :item, foreign_key: true
      t.string :content
      t.integer :rating
      t.string :author

      t.timestamps
    end
  end
end
