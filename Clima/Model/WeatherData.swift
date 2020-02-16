//
//  WeatherData.swift
//  Clima
//
//  Created by Archit Garg on 16/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable{
    let message : String
    let list : [List]
}

struct List : Codable{
    let id : Int
    let name : String
    let weather : [Weather]
    let main : Main
}

struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {
    let id : Int
}
