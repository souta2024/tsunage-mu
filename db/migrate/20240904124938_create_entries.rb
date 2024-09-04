class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :user
      t.references :direct_message

      t.timestamps
    end
  end
end
