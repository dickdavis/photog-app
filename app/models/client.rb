# frozen_string_literal: true

##
# = Client
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides validations and methods for the client model.
class Client < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  validates :phone_number, presence: true

  ##
  # Provides search query for client model
  def self.search(query)
    where('first_name ILIKE ? OR last_name ILIKE ?', query, query)
  end
end
