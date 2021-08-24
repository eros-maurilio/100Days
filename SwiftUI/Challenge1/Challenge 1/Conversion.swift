//
//  Conversion.swift
//  Challenge 1
//
//  Created by Eros Maurilio on 12/08/21.
//

import Foundation

enum Scale {
    case fahrenheit
    case celsius
    case kelvin
    
}

func converter(temperature: String, temperatureScale: Scale) -> [Double] {
    let currentTemperature = Double(temperature) ?? 0
    var conversionList = [Double]()
    
    
    switch temperatureScale {
    case .celsius:
        let celsiusToFahrenheit = currentTemperature * 1.8 + 32
        let celsiusToKelvin = currentTemperature + 273.15
        
        conversionList.append(celsiusToFahrenheit)
        conversionList.append(celsiusToKelvin)
        
        return conversionList
        
    case .fahrenheit:
        let fahrenheitToCelsius = (currentTemperature - 32) * 5/9
        let fahrenheitToKelvin = (currentTemperature - 32) * 5/9 + 273.15
        
        conversionList.append(fahrenheitToCelsius)
        conversionList.append(fahrenheitToKelvin)
        
        return conversionList
        
    case .kelvin:
        let kelvinToCelsius = currentTemperature - 273.15
        let kelvinTofahrenheit = (currentTemperature - 273.15) * 9/5 + 32
        
        conversionList.append(kelvinToCelsius)
        conversionList.append(kelvinTofahrenheit)
        
        return conversionList
    }
    
}
