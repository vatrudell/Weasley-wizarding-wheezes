class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.float :price 
      t.string :image_tag

      t.timestamps null: false
    end
  end
end
