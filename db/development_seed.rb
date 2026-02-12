class DevelopmentSeed
  def self.run
    new.run
  end

  def run
    return if Race.any?

    puts "Seeding development database..."

    # Create 6 F1 cars
    cars = [
      { number: 1, team: "Red Bull Racing", driver_name: "Max Verstappen" },
      { number: 44, team: "Mercedes-AMG Petronas", driver_name: "Lewis Hamilton" },
      { number: 16, team: "Scuderia Ferrari", driver_name: "Charles Leclerc" },
      { number: 4, team: "McLaren Racing", driver_name: "Lando Norris" },
      { number: 14, team: "Aston Martin", driver_name: "Fernando Alonso" },
      { number: 11, team: "Red Bull Racing", driver_name: "Sergio Pérez" }
    ].map { |data| Car.create!(data) }
    puts "Created #{cars.count} cars"

    # Create Monaco GP
    monaco = Race.create!(
      name: "Monaco Grand Prix 2026",
      track_name: "Circuit de Monaco",
      start_time: 1.week.ago,
      end_time: 1.week.ago + 2.hours,
      start_latitude: 43.734699,
      start_longitude: 7.420564,
      finish_latitude: 43.734699,
      finish_longitude: 7.420564
    )

    # Create upcoming Silverstone GP
    Race.create!(
      name: "British Grand Prix 2026",
      track_name: "Silverstone Circuit",
      start_time: 1.week.from_now,
      end_time: 1.week.from_now + 2.hours,
      start_latitude: 52.073611,
      start_longitude: -1.014722,
      finish_latitude: 52.073611,
      finish_longitude: -1.014722
    )
    puts "Created #{Race.count} races"

    # Add cars to Monaco race
    participants = cars.map do |car|
      RaceParticipant.create!(race: monaco, car: car)
    end
    puts "Added #{participants.count} participants to Monaco"

    # Generate 10 laps per participant with realistic times
    base_times = { 1 => 74.5, 44 => 75.0, 16 => 74.8, 4 => 75.2, 14 => 75.7, 11 => 75.9 }
    lap_count = 0

    participants.each do |participant|
      base_time = base_times[participant.car.number]
      current_time = monaco.start_time

      10.times do |lap_num|
        variation = rand(-1.5..1.5)
        variation += 5.0 if lap_num == 0  # Slower first lap
        variation += 25.0 if lap_num == 5  # Pit stop on lap 5

        lap_time_seconds = base_time + variation
        lap_end = current_time + lap_time_seconds.seconds

        Lap.create!(
          race_participant: participant,
          lap_number: lap_num + 1,
          start_time: current_time,
          end_time: lap_end
        )

        current_time = lap_end
        lap_count += 1
      end
    end
    puts "Generated #{lap_count} laps"

    puts "\n Seeding complete!"
  end
end
