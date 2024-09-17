class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :direct_message, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
