class CreateCommentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_histories do |t|
      t.references :post, null: false, foreign_key: true
      t.text :body, null: false
      t.datetime :edit_datetime, null: false

      t.timestamps
    end
  end
end
