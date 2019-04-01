# frozen_string_literal: true

##
# = ApplicationHelper
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions
# License::   GNU Public License 3
#
# This controller provides helper methods for all application views.
module ApplicationHelper
  def format_date(date)
    date.strftime('%B %e, %Y')
  end

  def format_time(time)
    time.strftime('%I:%M %p')
  end
end
