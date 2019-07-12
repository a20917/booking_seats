class ChangeNameToUserId < ActiveRecord::Migration[5.0]
  def change
    rename_column :bookings, :name, :user_id
  end
end
