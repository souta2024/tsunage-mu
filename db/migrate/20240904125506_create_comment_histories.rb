class CreateCommentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_histories do |t|
      t.references :post
      t.text :body

      t.timestamps
    end
  end
end
