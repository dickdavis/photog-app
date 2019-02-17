# frozen_string_literal: true

##
# = ClientsController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides methods for accessing client resources.
class ClientsController < ApplicationController
  before_action :require_login
  before_action :set_client, only: %i[show edit update destroy]

  ##
  # GET /clients
  def index
    @clients = if params[:search]
                 Client.search(params[:search]).order('created_at DESC')
               else
                 Client.all
               end
  end

  ##
  # GET /clients/:client_id
  def show; end

  ##
  # GET /clients/new
  def new
    @client = Client.new
  end

  ##
  # GET /clients/:client_id/edit
  def edit; end

  ##
  # POST /clients
  def create
    @client = Client.create(client_params)

    if @client.save
      redirect_to client_path(@client), notice: t('notices.client.create')
    else
      redirect_to new_client_path, alert: @client.errors.full_messages
    end
  end

  ##
  # PATCH/PUT /clients/:client_id
  def update
    if @client.update(client_params)
      redirect_to client_path(@client), notice: t('notices.client.update')
    else
      redirect_to edit_client_path(@client), alert: @client.errors.full_messages
    end
  end

  ##
  # DELETE /clients/:client_id
  def destroy
    @client.destroy
    redirect_to clients_path, notice: t('notices.client.destroy')
  end

  private

  ##
  # Sets client for individual resource actions
  def set_client
    @client = Client.find(params[:id])
  end

  ##
  # Whitelists parameters
  def client_params
    params.require(:client).permit(:first_name, :last_name, :email, :phone_number, :search)
  end
end
