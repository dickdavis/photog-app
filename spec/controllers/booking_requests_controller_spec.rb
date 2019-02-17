# frozen_string_literal: true

require 'rails_helper'

describe 'Booking Requests Controller', type: :request do
  let(:user) { create(:user) }
  let(:package) { create(:package) }
  let(:booking_request) { create(:booking_request) }

  context 'as a guest' do
    it 'redirects away from the show page' do
      get booking_request_path(booking_request)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects away from the edit page' do
      get edit_booking_request_path(booking_request)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the update path' do
      expect do
        patch booking_request_path(booking_request, booking_request: attributes_for(:booking_request, last_name: 'Test'))
        booking_request.reload
      end.to_not change(booking_request, :last_name)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the confirm path' do
      expect do
        post confirm_booking_request_path(booking_request)
      end.to change(Client, :count).by(0)
                                   .and change(BookingPackage, :count).by(0)
                                                                      .and change(Booking, :count).by(0)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects from the destroy path' do
      delete booking_request_path(booking_request)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  context 'as a user' do
    it 'displays the book now page' do
      get new_booking_request_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :new
    end

    it 'displays the show page' do
      get booking_request_path(booking_request, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
    end

    it 'displays the edit page' do
      get edit_booking_request_path(booking_request, as: user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :edit
    end

    it 'fails to create with invalid parameters' do
      expect do
        post booking_requests_path(booking_request: attributes_for(:booking_request))
      end.to_not change(BookingRequest, :count)
      expect(flash[:alert]).to eq(['Package must exist', "Package can't be blank"])
      expect(response).to redirect_to(new_booking_request_path)
    end

    it 'creates with valid parameters' do
      expect do
        post booking_requests_path(booking_request: attributes_for(:booking_request, package_id: package.id))
      end.to change(BookingRequest, :count).by(1)
      expect(flash[:notice]).to match(/Your booking request has been submitted! We will be in contact soon./)
      expect(response).to redirect_to(root_path)
    end

    it 'fails to update with invalid parameters' do
      expect do
        patch booking_request_path(booking_request, booking_request: attributes_for(:booking_request, last_name: ''), as: user)
        booking_request.reload
      end.to_not change(booking_request, :last_name)
      expect(flash[:alert]).to eq(["Last name can't be blank"])
      expect(response).to redirect_to(booking_request_path(booking_request))
    end

    it 'updates with valid parameters' do
      expect do
        patch booking_request_path(booking_request, booking_request: attributes_for(:booking_request, last_name: 'Test'), as: user)
        booking_request.reload
      end.to change(booking_request, :last_name)
      expect(flash[:notice]).to match(/Booking request was successfully updated./)
      expect(response).to redirect_to(booking_request_path(booking_request))
    end

    it 'confirms a booking request' do
      expect do
        post confirm_booking_request_path(booking_request, as: user)
      end.to change(Client, :count).by(1)
                                   .and change(BookingPackage, :count).by(1)
                                                                      .and change(Booking, :count).by(1)
      expect(flash[:notice]).to match(/Booking request successfully approved./)
      expect(response).to redirect_to(dashboard_path)
    end

    it 'destroys the booking request' do
      delete booking_request_path(booking_request, as: user)
      expect(flash[:notice]).to match(/Booking request was successfully deleted./)
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
