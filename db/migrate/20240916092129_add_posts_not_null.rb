class AddPostsNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :body, false
    change_column_null :posts, :is_public, false
    change_column_null :posts, :is_hidden, false
  end
end
