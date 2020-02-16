//
//  WeatherManager.swift
//  Clima
//
//  Created by Archit Garg on 11/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?units=metric&appid=e0eaa283b87793105b204feaa0b5a7d1"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String) {
        // 1. Create URL
        
        if let url = URL(string: urlString) {
            // 2. Create URLSession
            
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.list[0].name)
            let id = decodedData.list[0].weather[0].id
            let name = decodedData.list[0].name
            let temp = decodedData.list[0].main.temp
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch {
            print(error)
            return nil
        }
    }
    
}
