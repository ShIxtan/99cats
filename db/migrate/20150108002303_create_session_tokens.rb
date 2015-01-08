class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false, index: true
      t.string :token, null: false, unique: true, index: true

      t.timestamps null: false
    end
  end
end
