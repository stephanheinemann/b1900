//
//  Plate.swift
//
//  Created by Stephan Heinemann on 2022-12-03.
//

import Foundation

/**
 A plate is an identifiable and nameable entity that holds an altimeter setting source used to correct  contained
 altitudes.
 */
public class Plate: Identifiable, Nameable {
    
    /// the name of this plate
    private var name: String = "";
    
    /// the altimeter setting source of this plate
    private var ass: AltimeterSettingSource;
    
    /// the altitude corrections of this plate
    private var altCorrections: Set<AltitudeCorrection> = [];
    
    /**
     Initializes this plate with an altimeter setting source.
     - Parameters:
     - ass: the altemeter setting source
     */
    public init(_ name: String, _ ass: AltimeterSettingSource) {
        self.name = name;
        self.ass = ass;
    }
    
    /**
     Gets the name of this plate.
     - Returns: the name of this plate
     */
    public func getName() -> String {
        return self.name;
    }
    
    /**
     Sets the name of this plate.
     - Parameters:
     - name: the name to be set
     */
    public func setName(_ name: String) {
        self.name = name;
    }
    
    /**
     Adds an altitude correction to this plate.
     - Parameters:
     - altCorrection: the altitude correction to be added
     */
    public func addAltitudeCorrection(_ altCorrection: AltitudeCorrection) {
        _ = altCorrection.correctFor(self.ass);
        self.altCorrections.insert(altCorrection);
    }
    
    /**
     Removes an altitude correction from this plate.
     - Parameters:
     - altCorrection: the altitude correction to be removed
     */
    public func removeAltitudeCorrection(_ altCorrection: AltitudeCorrection) {
        self.altCorrections.remove(altCorrection);
    }
    
    /**
     Updates the altitude corrections of this plate.
     */
    public func update() {
        for altCorrection in self.altCorrections {
            _ = altCorrection.correctFor(self.ass);
        }
    }
    
}
