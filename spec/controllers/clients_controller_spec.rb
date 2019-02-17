# frozen_string_literal: true

require 'rails_helper'

describe 'Clients Controller', type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client) }

  context 'as a guest' do
    it 'redirects away from the index page' do
      get clients_path
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the new page' do
      get new_client_path
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the show page' do
      get client_path(client)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the edit page' do
      get edit_client_path(client)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the create path' do
      expect do
        post clients_path(client: attributes_for(:client))
      end.to_not change(Client, :count)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the update path' do
      expect do
        patch client_path(client, client: attributes_for(:client, first_name: 'Test'))
        client.reload
      end.to_not change(client, :first_name)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the destroy path' do
      delete client_path(client)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  context 'as a user' do
    it 'displays the index page' do
      get clients_path(as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :index
    end

    it 'displays the new page' do
      get new_client_path(as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :new
    end

    it 'displays the show page' do
      get client_path(client, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
    end

    it 'displays the edit page' do
      get edit_client_path(client, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :edit
    end

    it 'fails to create with invalid parameters' do
      expect do
        post clients_path(client: attributes_for(:client, first_name: ''), as: user)
      end.to_not change(Client, :count)
      expect(flash[:alert]).to eq(["First name can't be blank"])
      expect(response).to redirect_to(new_client_path)
    end

    it 'creates with valid parameters' do
      expect do
        post clients_path(client: attributes_for(:client), as: user)
      end.to change(Client, :count).by(1)
      expect(flash[:notice]).to match(/Client was successfully created./)
      expect(response).to redirect_to(client_path(Client.last))
    end

    it 'fails to update with invalid parameters' do
      expect do
        patch client_path(client, client: attributes_for(:client, first_name: ''), as: user)
        client.reload
      end.to_not change(client, :first_name)
      expect(flash[:alert]).to eq(["First name can't be blank"])
      expect(response).to redirect_to(edit_client_path(client))
    end

    it 'updates with valid parameters' do
      expect do
        patch client_path(client, client: attributes_for(:client, first_name: 'Test'), as: user)
        client.reload
      end.to change(client, :first_name)
      expect(flash[:notice]).to match(/Client was successfully updated./)
      expect(response).to redirect_to(client_path(client))
    end

    it 'destroys the client' do
      delete client_path(client, as: user)
      expect(flash[:notice]).to match(/Client was successfully deleted./)
      expect(response).to redirect_to(clients_path)
    end
  end
end
