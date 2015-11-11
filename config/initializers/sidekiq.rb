if !Rails.env.test?
  require 'sidekiq/testing/inline'
end