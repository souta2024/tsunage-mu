class CreatePostHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :post_histories do |t|
      t.references :post
      t.text :body

      t.timestamps
    end
  end
end
