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
    
    static func hw1() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/5")
        if let url {
            let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
               if let data {
                   do {
                       let serData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       if let serData {
                           if let title = serData["title"] as? String {
                               print(title)
                           }
                       }
                   } catch let error{
                       print("error_1: ",error.localizedDescription)
                   }
                }
                
                if let error {
                    print("error: ",error.localizedDescription)
                }
            }
            
            urlSession.resume()
        }
    }
    
    static func hw2() {
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    do {
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let planet = try decoder.decode(Planet.self, from: data)
                        
                        planet.residents.forEach { resident in
                            
                            if let url = URL(string: resident) {
                               
                                let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
                                    if let data {
                                        do {
                                            let resident = try JSONDecoder().decode(Resident.self, from: data)
                                            print(resident.name)
                                        } catch {
                                            print("error_2: ",error.localizedDescription)
                                        }
                                        
                                    }
                                }
                                urlSession.resume()
                            }
                        }
                        
                        
                        
                    } catch let error {
                        print("error_1: ",error.localizedDescription)
                    }
                }
                
                if let error {
                    print("error: ",error.localizedDescription)
                }
            }
            urlSession.resume()
        }
    }
}

struct Planet : Decodable {
    var residents : [String]
//    var rotationPeriod: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case rotationPeriod = "rotation_period"
//    }
}

struct Resident : Decodable {
    var name: String
}

enum AppConfiguration: String {
    case first = "https://swapi.dev/api/people/8"
    case second = "https://swapi.dev/api/starships/3"
    case third = "https://swapi.dev/api/planets/5"
}

/*
     "userId": 1,
     "id": 1,
     "title": "delectus aut autem",
     "completed": false
   
 */
