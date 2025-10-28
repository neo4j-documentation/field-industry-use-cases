:params {
  max_mins: 700, // maximum allowed duration of the trip in minutes
  car_id: "Car1",
  source_geo_name: "Paris", // place of departure place
  target_geo_name: "Marseille", // place of arrival
  detour_ratio: 1.2, // You need to be at any step on traversal at most at detour_ratio * distance(source, target) from source or target
  min_soc: 1, // state of charge can't be below min_soc percents
  max_soc: 100, // state of charge can't be above max_soc percents
  departure_datetime: datetime("2025-10-15T17:46:16.114000000Z")
}