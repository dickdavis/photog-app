# frozen_string_literal: true

##
# = ApplicationHelper
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides helper methods for all application views.
module ApplicationHelper
  def format_datetime(date)
    Time.at(date).strftime('%B %e, %Y at %I:%M %p')
  end
end
