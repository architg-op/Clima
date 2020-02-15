//
//  WeatherData.swift
//  Clima
//
//  Created by Archit Garg on 16/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable{
    let message : String
    let list : [List]
    
}

struct List : Decodable{
    let name : String
}
