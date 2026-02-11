class DevelopmentSeed
  def self.run
    new.run
  end

  def run
    return if Race.any?

    Race.create(
      name: "The Great Race",
      track_name: "The Great Race",
      start_time: Time.now,
      end_time: Time.now + 1.hour,
      start_latitude: 51.507351,
      start_longitude: -0.127758,
      finish_latitude: 51.508174,
      finish_longitude: -0.127515
    )
  end
end
