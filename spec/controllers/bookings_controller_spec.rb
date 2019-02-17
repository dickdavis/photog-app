# frozen_string_literal: true

require 'rails_helper'

describe 'Bookings Controller', type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:booking_package) { create(:booking_package) }
  let(:booking) { create(:booking, booking_package: booking_package, client: client) }

  context 'as a guest' do
    it 'redirects from the index page' do
      get bookings_path
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the new page' do
      get new_booking_path
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the show page' do
      get booking_path(booking)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the edit page' do
      get edit_booking_path(booking)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the create path' do
      expect do
        post bookings_path(booking: attributes_for(:booking))
      end.to_not change(Booking, :count)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the update path' do
      expect do
        patch booking_path(booking, booking: attributes_for(:booking, name: 'Test'))
        booking.reload
      end.to_not change(Booking, :name)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the destroy path' do
      delete booking_path(booking)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  context 'as a user' do
    it 'displays the index page' do
      get bookings_path(as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :index
    end

    it 'displays the new page' do
      get new_booking_path(as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :new
    end

    it 'displays the show page' do
      get booking_path(booking, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
    end

    it 'displays the edit page' do
      get edit_booking_path(booking, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :edit
    end

    it 'fails to create with invalid parameters' do
      expect do
        post bookings_path(booking: attributes_for(:booking, client_id: client.id, booking_package_id: booking_package.id, name: ''), as: user)
      end.to_not change(Booking, :count)
      expect(flash[:alert]).to eq ["Name can't be blank"]
      expect(response).to redirect_to(new_booking_path)
    end

    it 'creates with valid parameters' do
      expect do
        post bookings_path(booking: attributes_for(:booking, client_id: client.id, booking_package_id: booking_package.id), as: user)
      end.to change(Booking, :count).by(1)
      expect(flash[:notice]).to match(/Booking was successfully created./)
      expect(response).to redirect_to(booking_path(Booking.last))
    end

    it 'fails to update with invalid parameters' do
      expect do
        patch booking_path(booking, booking: attributes_for(:booking, name: ''), as: user)
        booking.reload
      end.to_not change(booking, :name)
      expect(flash[:alert]).to eq(["Name can't be blank"])
      expect(response).to redirect_to(edit_booking_path(booking))
    end

    it 'updates with valid parameters' do
      expect do
        patch booking_path(booking, booking: attributes_for(:booking, name: 'A Test Update'), as: user)
        booking.reload
      end.to change(booking, :name)
      expect(flash[:notice]).to match(/Booking was successfully updated./)
      expect(response).to redirect_to(booking_path(booking))
    end

    it 'destroys the booking' do
      delete booking_path(booking, as: user)
      expect(flash[:notice]).to match(/Booking was successfully deleted./)
      expect(response).to redirect_to(bookings_path)
    end
  end
end
