Blueprinter.configure do |config|
  config.datetime_format = ->(datetime) do
    datetime&.utc&.iso8601(0)
  end
end
