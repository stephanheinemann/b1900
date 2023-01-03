//
//  AltimeterSettingSource.swift
//
//  Created by Stephan Heinemann on 2022-12-02.
//

import Foundation

public class AltimeterSettingSource: Identifiable {
    
    /// the elevation of this altimeter setting source
    private var elevation: Altitude = StandardAtmosphere.standardElevationMSL;
    
    /// the altimeter of this altimeter setting source
    private var altimeter: Pressure = StandardAtmosphere.standardPressureMSL;
    
    /// the temperature of this altimeter setting source
    private var temperature: Temperature = StandardAtmosphere.standardTemperatureMSL;
    
    /// the mean sea level temperature of this altimeter setting source according to the standard atmosphere
    private lazy var temperatureMSL: Temperature
        = Temperature(value: self.temperature
                        .converted(to: UnitTemperature.celsius).value
        + (StandardAtmosphere.standardTemperatureLapseRate
            .converted(to: UnitTemperatureLapseRate.celsiusPerFeet).value
            * self.elevation.converted(to: UnitLength.feet).value),
                      unit: UnitTemperature.celsius);
    // TODO: observation time and other properties
    
    public init() {}
    
    public init(_ elevation: Altitude, _ altimeter: Pressure,
                _ temperature: Temperature) {
        self.elevation = elevation;
        self.altimeter = altimeter;
        self.temperature = temperature;
    }
    
    public func getElevation() -> Altitude {
        return self.elevation;
    }
    
    public func getAltimeter() -> Pressure {
        return self.altimeter;
    }
    
    public func getTemperature() -> Temperature {
        return self.temperature;
    }
    
    public func getTemperatureMSL() -> Temperature {
        return self.temperatureMSL;
    }
    
}
