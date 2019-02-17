# frozen_string_literal: true

require 'rails_helper'

describe 'Dashboard Controller', type: :request do
  let(:user) { create(:user) }

  context 'as a guest' do
    it 'redirects from the show page' do
      get dashboard_path
      expect(response).to redirect_to(sign_in_path)
    end
  end

  context 'as a user' do
    it 'displays the show page' do
      get dashboard_path(as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
    end
  end
end
