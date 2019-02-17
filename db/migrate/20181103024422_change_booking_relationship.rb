# frozen_string_literal: true

class ChangeBookingRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_index :booking_packages, :booking_id
    remove_foreign_key :booking_packages, :bookings
    remove_column :booking_packages, :booking_id
  end
end
