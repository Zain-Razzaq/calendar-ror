require "stripe"

Rails.application.config.stripe = {
  publishable_key: ENV["STRIPE_TEST_PUBISHABLE_KEY"],
  secret_key: ENV["STRIPE_TEST_SECRET_KEY"]
}

Stripe.api_key = Rails.application.config.stripe[:secret_key]
