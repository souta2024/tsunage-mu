class CreateCommentFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_favorites do |t|
      t.references :user
      t.references :comment

      t.timestamps
    end
  end
end
