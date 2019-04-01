class AddRequestedTimeToBookingRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :booking_requests, :requested_time, :time
    change_column :booking_requests, :requested_date, :date
    add_column :bookings, :start_date, :date
    change_column :bookings, :start_time, :time
  end
end
