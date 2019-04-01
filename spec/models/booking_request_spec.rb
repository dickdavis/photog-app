# frozen_string_literal: true

require 'rails_helper'

describe BookingRequest, type: :model do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :requested_date }
    it { should validate_presence_of :requested_time }
    it { should validate_presence_of :package_id }
  end
end
