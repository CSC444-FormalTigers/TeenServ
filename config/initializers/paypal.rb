#PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

PayPal::SDK.configure(
  :mode      => "sandbox",
  :app_id    => "APP-80W284485P519543T",
  :username  => ENV["PAYPAL_USERNAME"],
  :password  => ENV["PAYPAL_PASSWORD"],
  :signature => ENV["PAYPAL_SIGNATURE"] )
