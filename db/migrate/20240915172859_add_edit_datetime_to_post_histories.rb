class AddEditDatetimeToPostHistories < ActiveRecord::Migration[6.1]
  def change
    add_column :post_histories, :edit_datetime, :datetime
  end
end
