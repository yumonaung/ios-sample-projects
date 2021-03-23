//
//  WeatherData.swift
//  Clima
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon. All rights reserved.
//

import Foundation

struct WeatherData :Codable {
    let name: String
    let main: Main
    let weather : [Weather]
}

struct Main :Codable {
   let temp: Double
   let feels_like: Double
   let temp_min: Double
   let temp_max: Double
   let pressure: Int
   let humidity: Int
}

struct Weather :Codable {
   let id: Int
   let main: String
   let description: String
   let icon: String
}
