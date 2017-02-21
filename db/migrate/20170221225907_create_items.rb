class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.decimal :price, :precision => 2
      t.string :image_tag

      t.timestamps null: false
    end
  end
end
