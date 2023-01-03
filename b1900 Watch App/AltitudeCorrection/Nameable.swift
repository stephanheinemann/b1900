//
//  Nameable.swift
//
//  Created by Stephan Heinemann on 2022-12-04.
//

import Foundation

public protocol Nameable {
    
    func getName() -> String;
    func setName(_ name: String);
}
