//
//  API.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

class API {
    
    static let shared: API = API()
    
    private let baseURL = "https://hotmart-mobile-app.herokuapp.com/"
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    private func makeRequest<E: Decodable>(with httpMethod: HTTPMethod, and path: String, and completion: @escaping (Result<[E], Error>) -> Void, and queryItems: [String: String]? = nil) {
        var components = URLComponents(string: baseURL + path)
        
        
        if let queryItems = queryItems {
            for key in queryItems.keys {
                components?.queryItems?.append(URLQueryItem(name: key, value: queryItems[key]))
            }
        }
        
        guard let componentsURL = components, let url = componentsURL.url else {
            return
        }
        
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10000)
        urlRequest.httpMethod = httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let dataResponse = data else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    guard let responseJSON = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any], let results = responseJSON[responseJSON.keys.first ?? ""] as? [[String: Any]] else {
                        return
                    }
                    var list: [E] = []
                    for result in results {
                        if let data = try? JSONSerialization.data(withJSONObject: result, options: []), let place = try? JSONDecoder().decode(E.self, from: data) {
                          list.append(place)
                        }
                    }
                    print(list)
                    completion(.success(list))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func makeRequest<E: Decodable>(with httpMethod: HTTPMethod, and path: String, and queryItems: [String: String]? = nil, and completion: @escaping (Result<E, Error>) -> Void) {
        var components = URLComponents(string: baseURL + path)
        
        if let queryItems = queryItems {
            for key in queryItems.keys {
                components?.queryItems?.append(URLQueryItem(name: key, value: queryItems[key]))
            }
        }
        
        guard let componentsURL = components, let url = componentsURL.url else {
            return
        }
        
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10000)
        urlRequest.httpMethod = httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let dataResponse = data else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    let object = try JSONDecoder.init().decode(E.self, from: dataResponse)
                    completion(.success(object))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getPlaces(with completion: @escaping (Result<[Place], Error>) -> Void) {
        makeRequest(with: .get, and: "locations", and: completion)
    }
    
    func getPlaceDetails(with id: Int, and completion: @escaping (Result<PlaceDetails, Error>) -> Void) {
        makeRequest(with: .get, and: "locations/\(String(id))") { (result) in
            completion(result)
        }
    }
    
    
    
    
}
