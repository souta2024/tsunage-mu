class AddEditDatetimeToCommentHistories < ActiveRecord::Migration[6.1]
  def change
    add_column :comment_histories, :edit_datetime, :datetime
  end
end
