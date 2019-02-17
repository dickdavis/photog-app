# frozen_string_literal: true

require 'rails_helper'

describe BookingPackage, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :retainer_fee }
    it { should validate_presence_of :total_cost }
  end
end
