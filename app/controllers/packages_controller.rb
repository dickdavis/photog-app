# frozen_string_literal: true

##
# = PackagesController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides methods for accessing package resources.
#
# Packages belong to one package group.
class PackagesController < ApplicationController
  before_action :require_login
  before_action :set_package, only: %i[show edit update destroy]
  before_action :set_package_group, only: %i[show create new edit update]

  ##
  # GET /package_groups/:package_group_id/packages/:package_id
  def show; end

  ##
  # GET /package_groups/:package_group_id/packages/new
  def new
    @package = @package_group.packages.new
  end

  ##
  # GET /package_groups/:package_group_id/packages/:package_id/edit
  def edit; end

  ##
  # POST /package_groups/:package_group_id/packages
  def create
    @package = @package_group.packages.create(package_params)

    if @package.save
      redirect_to package_group_package_path(@package_group, @package), notice: t('notices.package.create')
    else
      redirect_to new_package_group_package_path(@package_group, @package), alert: @package.errors.full_messages
    end
  end

  ##
  # PATCH/PUT /package_groups/:package_group_id/packages/:package_id
  def update
    if @package.update(package_params)
      redirect_to package_group_package_path(@package_group, @package), notice: t('notices.package.update')
    else
      redirect_to edit_package_group_package_path(@package_group, @package), alert: @package.errors.full_messages
    end
  end

  ##
  # DELETE /package_groups/:package_group_id/packages/:package_id
  def destroy
    @package.destroy
    redirect_to package_groups_path, notice: t('notices.package.destroy')
  end

  private

  ##
  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end

  ##
  # Use callbacks to share common setup or constraints between actions.
  def set_package_group
    @package_group = PackageGroup.find(params[:package_group_id])
  end

  ##
  # Never trust parameters from the scary internet, only allow the white list through.
  def package_params
    params.require(:package).permit(:name, :description, :total_cost, :retainer_fee, :duration, :package_group_id)
  end
end
