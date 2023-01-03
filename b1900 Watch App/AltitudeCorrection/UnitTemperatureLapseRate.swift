//
//  UnitTemperatureLapseRate.swift
//
//  Created by Stephan Heinemann on 2022-12-02.
//

import Foundation

public final class UnitTemperatureLapseRate: Dimension {
    
    public static let kelvinPerMeter: UnitTemperatureLapseRate
        = UnitTemperatureLapseRate(symbol: "dkpm", converter: UnitConverterLinear(coefficient: 1.0));
    public static let kelvinPerFeet: UnitTemperatureLapseRate
        = UnitTemperatureLapseRate(symbol: "dkpf", converter: UnitConverterLinear(coefficient: 3.2808));
    
    public static let celsiusPerMeter: UnitTemperatureLapseRate
        = UnitTemperatureLapseRate(symbol: "dcpm", converter: UnitConverterLinear(coefficient: 1.0));
    public static let celsiusPerFeet: UnitTemperatureLapseRate
        = UnitTemperatureLapseRate(symbol: "dcpf", converter: UnitConverterLinear(coefficient: 3.2808));
    // TODO: more temperature and length conversions
    
    //public static let baseUnit: UnitTemperatureLapseRate = UnitTemperatureLapseRate.kelvinPerMeter;
    
    public override class func baseUnit() -> UnitTemperatureLapseRate {
        return UnitTemperatureLapseRate.kelvinPerMeter;
    }
    
    //static let baseUnit: UnitTemperatureLapseRate = UnitTemperatureLapseRate.kelvinPerMeter;
    
    /*
    public static func feetToMeters(feet: Float) -> Float {
        return feet * 0.3048;
    }
    
    public static func metersToFeet(meters: Float) -> Float {
        return meters / 0.3048;
    }
    
    public static func kelvinToCelsius(kelvin: Float) -> Float {
        return kelvin - 273.15;
    }
    
    public static func celsiusToKelvin(celsius: Float) -> Float {
        return celsius + 273.15;
    }
    
    public static func celsiusToFahrenheit(celsius: Float) -> Float {
        return (celsius * 1.8) + 32.0;
    }
    
    public static func fahrenheitToCelsius(fahrenheit: Float) -> Float {
        return (fahrenheit - 32.0) / 1.8;
    }
    */
}
