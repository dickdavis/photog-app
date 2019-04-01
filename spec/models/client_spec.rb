# frozen_string_literal: true

require 'rails_helper'

describe Client, type: :model do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_length_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_length_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
  end
end
