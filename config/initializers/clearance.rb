Clearance.configure do |config|
  config.allow_sign_up = <%= ALLOW_SIGNUP %>
  config.mailer_sender = 'noreply@<%= MAILER_DOMAIN %>'
  config.rotate_csrf_on_sign_in = true
end
