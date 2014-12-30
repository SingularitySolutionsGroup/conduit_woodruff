require 'interchangeable'
require 'stripe'

Stripe.api_key = ENV["STRIPE_PRIVATE_KEY"]

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :allow_stripe) { true }

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :organization_name) do
  "Bryan University"
end

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :stripe_key) do
  ENV["STRIPE_PUBLISHABLE_KEY"]
end

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :default_amount) do
  50.00
end

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :default_description) do
  "Application Fee"
end

Interchangeable.define(HardcodedSpecialData::StripeHardcodedData, :stripe_logo) do
  '/assets/images/B-logo.jpg'
end
