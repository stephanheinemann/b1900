//
//  ContentView.swift
//  b1900 Watch App
//
//  Created by Stephan Heinemann on 2023-01-02.
//

import SwiftUI

var formatter: MeasurementFormatter = MeasurementFormatter();
var ass = AltimeterSettingSource(
    Altitude(value: 1000.0, unit: UnitLength.feet),
    Pressure(value: 29.92, unit: UnitPressure.inchesOfMercury),
    Temperature(value: -50.0, unit: UnitTemperature.celsius));
var alt1 = AltitudeCorrection(
    "Altitude 1", Altitude(value: 5000.0, unit: UnitLength.feet)).correctFor(ass);
var alt2 = AltitudeCorrection(
    "Altitude 2", Altitude(value: 2000.0, unit: UnitLength.feet)).correctFor(ass);
var plate = Plate("Plate 1", ass);
var message = "Hello, World!\n" +
    ass.getTemperature().description + "\n" +
    ass.getTemperatureMSL().description + "\n" +
    alt1.toString() + "\n" +
    alt2.toString();

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(message)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
