# frozen_string_literal: true

##
# = BookingsController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides methods for accessing booking resources.
class BookingsController < ApplicationController
  before_action :require_login
  before_action :set_booking, only: %i[show edit update destroy]

  ##
  # GET /bookings
  def index
    @bookings = if params[:client_id]
                  Booking.where('client_id = ?', params[:client_id])
                else
                  Booking.all
                end
  end

  ##
  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  ##
  # GET /bookings/:booking_id
  def show; end

  ##
  # GET /bookings/:booking_id/edit
  def edit; end

  ##
  # POST /bookings
  def create
    @booking = Booking.create(booking_from_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: t('notices.booking.create')
    else
      @booking.booking_package.destroy
      redirect_to new_booking_path, alert: @booking.errors.full_messages
    end
  end

  ##
  # PATCH/PUT /bookings/:booking_id
  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: t('notices.booking.update')
    else
      redirect_to edit_booking_path(@booking), alert: @booking.errors.full_messages
    end
  end

  ##
  # DELETE /bookings/:booking_id
  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: t('notices.booking.destroy')
  end

  private

  ##
  # Sets booking for individual resource actions
  def set_booking
    @booking = Booking.find(params[:id])
  end

  ##
  # Archives a package as a booking package
  def archive_package(package_id)
    package = Package.find(package_id)
    BookingPackage.create(name: package.name,
                          duration: package.duration,
                          retainer_fee: package.retainer_fee,
                          total_cost: package.total_cost)
  end

  def booking_from_params
    {
      name: booking_params[:name],
      start_date: booking_params[:start_date],
      start_time: booking_params[:start_time],
      client: Client.find(booking_params[:client_id]),
      booking_package: archive_package(booking_params[:booking_package])
    }
  end
  ##
  # Whitelists parameters
  def booking_params
    params.require(:booking).permit(:name, :start_date, :start_time, :client_id, :booking_package)
  end
end
