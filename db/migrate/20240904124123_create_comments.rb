class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :body, null: false
      t.boolean :is_draft, null: false, default: true
      t.boolean :is_hidden, null: false, default: false

      t.timestamps
    end
  end
end
