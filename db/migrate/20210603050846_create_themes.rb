class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.integer :user_id
      t.string :content
      t.string :image_id
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
