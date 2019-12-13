//
//  LocationAPIClient.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct LocationAPIClient {
    
    private init() {}
    
    static let shared = LocationAPIClient()
    
    func getLocationDataFrom(lat: Double, long: Double, completionHandler: @escaping (Result<LocationData, AppError>) -> ()) {
        let urlStr = "https://us1.locationiq.com/v1/reverse.php?key=\(LocationIQSecrets.apiKey)&lat=\(lat)&lon=\(long)&format=json"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                
                do {
                    let location = try LocationData.getLocationFromData(data: data)
                    completionHandler(.success(location!))
                }
                catch {
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
}
