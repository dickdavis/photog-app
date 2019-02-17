# frozen_string_literal: true

##
# = BookingRequestsHelper
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides helper methods for booking requests views.
module BookingRequestsHelper
  def format_packages(pkg_groups)
    Package.where(package_group_id: pkg_groups).order(total_cost: :asc)
  end
end
