# frozen_string_literal: true

##
# = PackageGroupsController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides methods for accessing package group resources.
#
# Package groups have many packages.
class PackageGroupsController < ApplicationController
  before_action :require_login
  before_action :set_package_group, only: %i[edit update destroy]

  ##
  # GET /package_groups/new
  def index
    @package_groups = PackageGroup.all
  end

  ##
  # GET /package_groups/new
  def new
    @package_group = PackageGroup.new
  end

  ##
  # GET /package_groups/:package_group/edit
  def edit; end

  ##
  # POST /package_groups
  def create
    @package_group = PackageGroup.create(package_group_params)

    if @package_group.save
      redirect_to package_groups_path, notice: t('notices.package_group.create')
    else
      redirect_to new_package_group_path, alert: @package_group.errors.full_messages
    end
  end

  ##
  # PATCH/PUT /package_groups/:package_group_id
  def update
    if @package_group.update(package_group_params)
      redirect_to package_groups_path, notice: t('notices.package_group.update')
    else
      redirect_to edit_package_group_path(@package_group), alert: @package_group.errors.full_messages
    end
  end

  ##
  # DELETE /package_groups/:package_group_id
  def destroy
    @package_group.destroy
    redirect_to package_groups_path, notice: t('notices.package_group.destroy')
  end

  private

  ##
  # Sets package group for individual resource actions
  def set_package_group
    @package_group = PackageGroup.find(params[:id])
  end

  ##
  # Whitelists parameters
  def package_group_params
    params.require(:package_group).permit(:name, :description)
  end
end
