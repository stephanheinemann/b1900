//
//  ColdWeatherCorrection.swift
//  B1900D WatchKit Extension
//
//  Created by Stephan Heinemann on 2022-11-25.
//

import Foundation

public class AltitudeCorrection: Identifiable, Nameable, Hashable {
    
    /// the name of this altitude correction
    private var name: String = "";
    
    /// the formatter of this altitude correction
    private let formatter: MeasurementFormatter = MeasurementFormatter();
    
    /// the decimal precision of this altitude correction
    private var decimalPrecision: Int = 0;
    
    /// the uncorrected altitude of this altitude correction
    private var altitude: Altitude = StandardAtmosphere.standardElevationMSL;
    
    /// the absolute altitude of this altitude correction
    private var absoluteAltitude: Altitude
        = Altitude(value: 0.0, unit: UnitLength.feet);
    
    /// the applied altitude correction of this altitude correction
    private var altitudeCorrection: Altitude
        = Altitude(value: 0.0, unit: UnitLength.feet);
    
    /// the resulting corrected altitude of this altitude correction
    private var correctedAltitude: Altitude
        = StandardAtmosphere.standardElevationMSL;
    
    
    public init() {
        self.formatter.numberFormatter.roundingMode
            = NumberFormatter.RoundingMode.up;
        self.formatter.numberFormatter.maximumFractionDigits
            = self.decimalPrecision;
        self.formatter.unitOptions = .providedUnit;
    }
    
    public convenience init(_ name: String, _ altitude: Altitude) {
        self.init();
        self.name = name;
        self.altitude = altitude;
    }
    
    public func getName() -> String {
        return self.name;
    }
    
    public func setName(_ name: String) {
        self.name = name;
    }
    
    public func getAltitude() -> Altitude {
        return self.altitude;
    }
    
    public func setAltitude(_ altitude: Altitude) {
        self.altitude = altitude;
    }
    
    public static func computeAbsoluteAltitude(
        _ altitude: Altitude, _ ass: AltimeterSettingSource) -> Altitude {
        return altitude - ass.getElevation();
    }
    
    public static func computeAltitudeCorrection(
        _ altitude: Altitude, _ ass: AltimeterSettingSource) -> Altitude {
        let aalt: Double = Self.computeAbsoluteAltitude(altitude, ass)
            .converted(to: UnitLength.feet).value;
        let dstd: Double = (StandardAtmosphere.standardTemperatureMSL
                                - ass.getTemperatureMSL())
            .converted(to:  UnitTemperature.celsius).value;
        let dtmp: Double = ass.getTemperatureMSL()
            .converted(to: UnitTemperature.kelvin).value
            - (0.5 * StandardAtmosphere.standardTemperatureLapseRate
                .converted(to: UnitTemperatureLapseRate.kelvinPerFeet).value
                * altitude.converted(to: UnitLength.feet).value);
        
        return Altitude(value: aalt * (dstd / dtmp), unit: UnitLength.feet);
    }
    
    public static func computeCorrectedAltitude(
        _ altitude: Altitude, _ ass: AltimeterSettingSource) -> Altitude {
        return altitude + Self.computeAltitudeCorrection(altitude, ass);
    }
    
    public func correctFor(_ ass: AltimeterSettingSource) -> AltitudeCorrection {
        self.absoluteAltitude = Self.computeAbsoluteAltitude(
            self.altitude, ass);
        self.altitudeCorrection = Self.computeAltitudeCorrection(
            self.altitude, ass);
        self.correctedAltitude = Self.computeCorrectedAltitude(
            self.altitude, ass);
        return self;
    }
    
    public func getAbsoluteAltitude() -> Altitude {
        return self.absoluteAltitude;
    }
    
    public func getAltitudeCorrection() -> Altitude {
        return self.altitudeCorrection;
    }
    
    public func getCorrectedAltitude() -> Altitude {
        return self.correctedAltitude;
    }
    
    // TODO: formatting should not be part of this
    public func toString() -> String {
        return self.getName() + ":\n" +
            self.formatter.string(from: self.getAbsoluteAltitude()) + "\n" +
            self.formatter.string(from: self.getAltitudeCorrection()) + "\n" +
            self.formatter.string(from: self.getCorrectedAltitude());
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id);
    }
    
    public static func ==(
        _ left: AltitudeCorrection, _ right: AltitudeCorrection) -> Bool {
        return left.id == right.id;
    }
    
}
