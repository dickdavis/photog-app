# frozen_string_literal: true

class AddRefToBookings < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :booking_package, foreign_key: true
  end
end
