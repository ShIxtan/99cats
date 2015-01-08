class AddUserIdToRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, index: true, null: false
  end
end
