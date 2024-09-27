class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.boolean :is_draft, null: false, default: true
      t.boolean :is_hidden, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
