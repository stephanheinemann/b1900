//
//  ColdWeatherCorrection.swift
//
//  Created by Stephan Heinemann on 2022-11-25.
//

import Foundation

public class ColdWeatherCorrection {
    
    private let formatter: MeasurementFormatter = MeasurementFormatter();
    private var decimalPrecision: Int = 0;
 
    // the applicable altimeter setting source
    private var ass: AltimeterSettingSource = AltimeterSettingSource();
    
    private var altitude: Altitude = StandardAtmosphere.standardElevationMSL;
    private var heightAboveASS: Altitude = Altitude(value: 0.0, unit: UnitLength.feet);
    private var altitudeCorrection: Altitude = Altitude(value: 0.0, unit: UnitLength.feet);
    private var correctedAltitude: Altitude = StandardAtmosphere.standardElevationMSL;
    
    /*
    // the aerodrome outside air temperature in degrees celsius
    private var oat: Float = ColdWeatherCorrection.STANDARD_TEMPERATURE_MSL;
    // the aerodrome elevation above mean sea level in feet
    private var elevation: Float = ColdWeatherCorrection.STANDARD_ELEVATION_MSL;
    // the mean sea level outside air temperature in degrees celsius
    private lazy var oatMSL = self.oat + (ColdWeatherCorrection.STANDARD_TEMPERATURE_LAPSE_RATE_FOOT * self.elevation);
    
    public init(oat: Float, elevation: Float) {
        self.oat = oat;
        self.elevation = elevation;
    }
    */
    public init() {
        self.formatter.numberFormatter.roundingMode = NumberFormatter.RoundingMode.up;
        self.formatter.numberFormatter.maximumFractionDigits = self.decimalPrecision;
        self.formatter.unitOptions = .providedUnit;
    }
    
    public convenience init(ass: AltimeterSettingSource) {
        self.init();
        self.ass = ass;
    }
    
    /*
    public convenience init(ass: AltimeterSettingSource, decimalPrecision: Int) {
        self.decimalPrecision = decimalPrecision;
        self.init();
    }
    */
    
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
    
    public func getAbsoluteAltitude(_ altitude: Altitude) -> Altitude {
        return altitude - self.ass.getElevation();
    }
    
    public func getAltitudeCorrection(_ altitude: Altitude) -> Altitude {
        let aalt: Double = self.getAbsoluteAltitude(altitude).converted(to: UnitLength.feet).value;
        let dstd: Double = (StandardAtmosphere.standardTemperatureMSL - self.ass.getTemperatureMSL()).converted(to:  UnitTemperature.celsius).value;
        let dtmp: Double = self.ass.getTemperatureMSL().converted(to: UnitTemperature.kelvin).value
            - (0.5 * StandardAtmosphere.standardTemperatureLapseRate.converted(to: UnitTemperatureLapseRate.kelvinPerFeet).value * altitude.converted(to: UnitLength.feet).value);
        
        return Altitude(value: aalt * (dstd / dtmp), unit: UnitLength.feet);
    }
    
    public func getCorrectedAltitude(_ altitude: Altitude) -> Altitude {
        return altitude + self.getAltitudeCorrection(altitude);
    }
    
    public func transform(_ altitude: Altitude) -> (Altitude, Altitude, Altitude) {
        return (self.getAbsoluteAltitude(altitude),
                self.getAltitudeCorrection(altitude),
                self.getCorrectedAltitude(altitude));
    }
    
    public func toString(altitude: Altitude) -> String {
        let transformation = self.transform(altitude);
        return self.formatter.string(from: transformation.0) + "\n" +
            self.formatter.string(from: transformation.1) + "\n" +
            self.formatter.string(from: transformation.2);
    }
    
}
