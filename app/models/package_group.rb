# frozen_string_literal: true

##
# = PackageGroup
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides validations and methods for the package groups model.
#
# Package group and package resources share a nested, one-to-many relationship.
class PackageGroup < ApplicationRecord
  has_many :packages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 75 }
  validates :description, length: { maximum: 256 }
end
