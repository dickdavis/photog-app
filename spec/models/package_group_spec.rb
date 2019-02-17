# frozen_string_literal: true

require 'rails_helper'

describe PackageGroup, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of :name }
    it { should validate_length_of :description }
  end
end
