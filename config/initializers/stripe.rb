require "stripe"

Rails.application.config.stripe = {
  publishable_key: "pk_test_51S2SqBLP6uE76iFa52BTtw42BRcEArS05scNRiRyX1s27N7RQCguSzABKshDpIwbfLD00X3YUyNO9af78nno9oMk006BcV3ABQ",
  secret_key: "sk_test_51S2SqBLP6uE76iFa8sP23GXOaJDOHWXlsLqGcJteRr1pg1PBHAG9yP5pAq1ejPawxGIloyzTpueIdypWSX1JlmAX00IUXY4CuJ"
}

Stripe.api_key = Rails.application.config.stripe[:secret_key]
