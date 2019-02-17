# frozen_string_literal: true

Clearance.configure do |config|
  config.allow_sign_up = ENV['ALLOW_SIGNUP']
  config.mailer_sender = "noreply@#{ENV['MAILER_DOMAIN']}"
  config.rotate_csrf_on_sign_in = true
end
