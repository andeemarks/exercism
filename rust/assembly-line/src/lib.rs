const BASE_PROD_RATE_PER_HOUR: f64 = 221.0;

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let production_rate: f64 = f64::from(speed) * BASE_PROD_RATE_PER_HOUR;

    if speed > 8 {
        production_rate * 0.77
    } else if speed > 4 {
        production_rate * 0.9
    } else {
        production_rate
    }
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed) / 60.0) as u32
}
