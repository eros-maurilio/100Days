//
//  ContentView.swift
//  Challenge 1
//
//  Created by Eros Maurilio on 12/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = ""
    @State private var temperatureSelected = 1
    let temperatureScale = ["Celsius", "Fahrenheit", "Kelvin"]
    var conversionCelsius: [Double] { converter(temperature: temperature, temperatureScale: .celsius) }
    var conversionFahrenheit: [Double] { converter(temperature: temperature, temperatureScale: .fahrenheit) }
    var conversionKelvin: [Double] { converter(temperature: temperature, temperatureScale: .kelvin) }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("0°", text: $temperature)
                        .keyboardType(.decimalPad)
                    
                    Picker("Current temperature scale", selection: $temperatureSelected) {
                        ForEach(0..<temperatureScale.count) {
                            Text("\(self.temperatureScale[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion")) {
                    switch temperatureSelected {
                    case 0:
                        Text("Fahrenheit: \(conversionCelsius[0], specifier: "%.2f")")
                        Text("Kelvin: \(conversionCelsius[1], specifier: "%.2f")")
                    case 1:
                        Text("Celsius: \(conversionFahrenheit[0], specifier: "%.2f")")
                        Text("Kelvin: \(conversionFahrenheit[1], specifier: "%.2f")")
                    default:
                        Text("Celsius: \(conversionKelvin[0], specifier: "%.2f")")
                        Text("Fahrenheit: \(conversionKelvin[1], specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
