# frozen_string_literal: true

##
# = PackageGroupsHelper
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides helper methods for package groups views.
module PackageGroupsHelper
  def element_for_pg_item(count)
    return '_triple' if (count % 3).zero?
    return '_double' if (count % 2).zero?
    return '_single' if (count % 1).zero?

    ''
  end
end
