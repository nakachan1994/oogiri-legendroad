class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :theme_id
      t.string :content
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
