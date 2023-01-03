//
//  Restriction.swift
//
//  Created by Stephan Heinemann on 2022-12-03.
//

import Foundation

public protocol Restriction: Identifiable, Hashable {

    associatedtype R;
    
    init(id: String);
    
    func getMaximum() -> R;
    func getMinimum() -> R;
    
}
