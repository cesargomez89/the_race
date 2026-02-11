require_relative 'development_seed'

if Rails.env.development?
  puts "Running development seeds..."
  DevelopmentSeed.run
end
