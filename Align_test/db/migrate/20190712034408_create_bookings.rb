class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :desk
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps
    end
  end
end
