//
//  StandardAtmosphere.swift
//
//  Created by Stephan Heinemann on 2022-12-02.
//

import Foundation

public class StandardAtmosphere {
    
    // the standard mean sea level elevation
    public static let standardElevationMSL: Altitude
        = Altitude(value: 0.0, unit: UnitLength.feet);
    // the standard temperature at mean sea level
    public static let standardTemperatureMSL: Temperature
        = Temperature(value: 15.0, unit: UnitTemperature.celsius);
    // the standard temperature lapse rate
    public static let standardTemperatureLapseRate: TemperatureLapseRate
        = TemperatureLapseRate(value: 0.0065, unit:  UnitTemperatureLapseRate.kelvinPerMeter); // 0.00198 degC/ft
    public static let standardPressureMSL: Pressure
        = Pressure(value: 1013.25, unit: UnitPressure.hectopascals);
    // TODO: more standard atmosphere properties
    
    // the standard temperature lapse rate per meter
    public static let STANDARD_TEMPERATURE_LAPSE_RATE_METER: Measurement<UnitTemperature> = Measurement(value: 0.0065, unit: UnitTemperature.celsius);
    // the standard temperature lapse rate per foot
    public static let STANDARD_TEMPERATURE_LAPSE_RATE_FOOT: Measurement<UnitTemperature> = Measurement(value: 0.00198, unit: UnitTemperature.celsius);
}
