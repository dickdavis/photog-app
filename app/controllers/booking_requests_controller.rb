# frozen_string_literal: true

##
# = BookingRequestsController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides methods for accessing booking requests resources.
class BookingRequestsController < ApplicationController
  before_action :require_login, only: %i[show edit update confirm destroy]
  before_action :set_booking_request, only: %i[show edit update destroy confirm]

  ##
  # GET /booking_requests/new
  def new
    @booking_request = BookingRequest.new
  end

  ##
  # GET /booking_requests/:booking_request_id
  def show; end

  ##
  # GET /booking_requests/:booking_request_id/edit
  def edit; end

  ##
  # POST /booking_requests
  def create
    @booking_request = BookingRequest.create(booking_request_params)

    if @booking_request.save
      redirect_to root_path, notice: t('notices.booking_request.create')
    else
      redirect_to new_booking_request_path, alert: @booking_request.errors.full_messages
    end
  end

  ##
  # PATCH/PUT /booking_requests/:booking_request_id
  def update
    if @booking_request.update(booking_request_params)
      redirect_to booking_request_path(@booking_request), notice: t('notices.booking_request.update')
    else
      redirect_to booking_request_path(@booking_request), alert: @booking_request.errors.full_messages
    end
  end

  ##
  # DELETE /booking_requests/:booking_request_id
  def destroy
    @booking_request.destroy
    redirect_to dashboard_path, notice: t('notices.booking_request.destroy')
  end

  ##
  # POST /booking_request/:booking_request_id/confirm
  def confirm
    client_from_params
    booking_package_from_params
    booking_from_params

    @booking_request.destroy

    redirect_to dashboard_path, notice: t('notices.booking_request.confirm')
  end

  private

  ##
  # Sets booking_request for individual resource actions
  def set_booking_request
    @booking_request = BookingRequest.find(params[:id])
  end

  ##
  # Creates a client from the params
  def client_from_params
    @client = Client.find_or_create_by(email: @booking_request.email) do |client|
      client.first_name = @booking_request.first_name
      client.last_name = @booking_request.last_name
      client.phone_number = @booking_request.phone_number
    end

    redirect_to dashboard_path, alert: t('alerts.client.create') unless @client.save
  end

  ## Creates a booking package from the params
  def booking_package_from_params
    @booking_package = BookingPackage.create do |bp|
      bp.name = @booking_request.package.name
      bp.duration = @booking_request.package.duration
      bp.retainer_fee = @booking_request.package.retainer_fee
      bp.total_cost = @booking_request.package.total_cost
    end

    redirect_to dashboard_path, alert: t('alerts.booking_package.create') unless @booking_package.save
  end

  ##
  # Creates a booking from params
  def booking_from_params
    @booking = Booking.create do |booking|
      booking.name = "#{@client.last_name}, #{@client.first_name} (#{@booking_request.package.name})"
      booking.start_date = @booking_request.requested_date
      booking.start_time = @booking_request.requested_time
      booking.client = @client
      booking.booking_package = @booking_package
    end

    redirect_to dashboard_path, alert: t('alerts.booking.create') unless @booking.save
  end

  ##
  # Whitelists parameters
  def booking_request_params
    params.require(:booking_request).permit(:first_name, :last_name, :email, :phone_number, :requested_date, :requested_time, :package_id)
  end
end
