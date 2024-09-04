class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.boolean :is_public
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
