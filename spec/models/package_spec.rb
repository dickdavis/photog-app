# frozen_string_literal: true

require 'rails_helper'

describe Package, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_length_of :description }
    it { should validate_presence_of :retainer_fee }
    it { should validate_presence_of :total_cost }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :package_group_id }
  end
end
