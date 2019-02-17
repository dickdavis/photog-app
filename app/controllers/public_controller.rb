# frozen_string_literal: true

##
# = PublicController
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# This controller provides methods for accessing the public facing views as well as
# any associated actions.
class PublicController < ApplicationController
  ##
  # /
  def index; end

  ##
  # /pricing
  def pricing
    @package_groups = PackageGroup.all
  end
end
