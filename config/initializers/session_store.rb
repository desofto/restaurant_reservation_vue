# frozen_string_literal: true

if Rails.env.test? || Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_restaurant_reservation_session', httponly: true
else
  Rails.application.config.session_store :redis_session_store, key: '_restaurant_reservation_session', redis: {
    expire_after: 30.minutes,
    key_prefix: 'restaurant_reservation:session:',
    url: 'redis://127.0.0.1:6379'
  }
end
