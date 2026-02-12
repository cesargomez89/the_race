require_relative 'development_seed'

if Rails.env.development?
  DevelopmentSeed.run
end
