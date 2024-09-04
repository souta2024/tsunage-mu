class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :post
      t.text :body
      t.boolean :is_public
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
