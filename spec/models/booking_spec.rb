# frozen_string_literal: true

require 'rails_helper'

describe Booking, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :client_id }
    it { should validate_presence_of :booking_package_id }
  end
end
