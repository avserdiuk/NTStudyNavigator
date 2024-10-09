//
//  NetworkService.swift
//  Navigator
//
//  Created by Алексей Сердюк on 09.10.2024.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let url = URL(string: configuration.rawValue)
        
        if let url {
            let urlSesion = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    let unwrappedData = String(data: data, encoding: .utf8)
                    print("unwrappedData: ", unwrappedData)
                }
                
                if let response {
                    let httpResponse = response as? HTTPURLResponse
                    print("statusCode: ", httpResponse?.statusCode ?? "")
                    print("allHeaderFields: ", httpResponse?.allHeaderFields ?? "")
                }
                
                if let error {
                    print("error: ",error.localizedDescription)
                }
            }
            urlSesion.resume()
        }
    }
}

enum AppConfiguration: String {
    case first = "https://swapi.dev/api/people/8"
    case second = "https://swapi.dev/api/starships/3"
    case third = "https://swapi.dev/api/planets/5"
}
