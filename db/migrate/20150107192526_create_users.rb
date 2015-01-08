class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, index: true, unique: true
      t.string :password_digest, null: false
      t.string :session_token, null: false, index: true, unique: true

      t.timestamps null: false
    end
  end
end
