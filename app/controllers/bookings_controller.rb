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
    @booking = Booking.create(booking_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: t('notices.booking.create')
    else
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
  # Whitelists parameters
  def booking_params
    params.require(:booking).permit(:name, :start_time, :client_id, :booking_package_id)
  end
end
