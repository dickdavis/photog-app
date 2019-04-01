# frozen_string_literal: true

##
# = Package
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides validations and methods for the packages model.
#
# Package group and package resources share a nested, one-to-many relationship.
class Package < ApplicationRecord
  belongs_to :package_group
  has_many :booking_requests, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 256 }
  validates :retainer_fee, presence: true
  validates :total_cost, presence: true
  validates :duration, presence: true
  validates :package_group_id, presence: true
end
