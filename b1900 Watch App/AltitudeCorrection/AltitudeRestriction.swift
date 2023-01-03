//
//  AltitudeRestriction.swift
//
//  Created by Stephan Heinemann on 2022-12-03.
//

import Foundation

public class AltitudeRestriction { //}: Restriction {
    
    public func getMaximum() -> Altitude {
        return Altitude(value: 0.0, unit: UnitLength.feet);
    }
    
    public func getMinimum() -> Altitude {
        return Altitude(value: 0.0, unit: UnitLength.feet);
    }
    
}
