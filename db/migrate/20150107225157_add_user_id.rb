class AddUserId < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, index: true, null: false
  end
end
