# frozen_string_literal: true

##
# = Booking
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides validations and methods for the booking model.
class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :booking_package

  validates :name, presence: true
  validates :start_time, presence: true
  validates :client_id, presence: true
  validates :booking_package_id, presence: true
end
