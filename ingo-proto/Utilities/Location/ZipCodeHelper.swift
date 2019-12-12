//
//  ZipCodeHelper.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/12/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class ZipCodeHelper {
    private init() {}
    
    
    static func getLatLong(fromZipCode zipCode: String, completionHandler: @escaping (Result<(lat: Double, long: Double), LocationFetchingError>) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate {
                        completionHandler(.success((coordinate.latitude, coordinate.longitude)))
                    } else {
                        let locationError: LocationFetchingError
                        if let error = error {
                            locationError = .error(error)
                        } else {
                            locationError = .noErrorMessage
                        }
                        completionHandler(.failure(locationError))
                    }
                }
            }
        }
    }
    
    
    static func getRegionInfo(lat: Double, long: Double, completion: @escaping (Result<CLPlacemark,LocationFetchingError>) -> Void ) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            
            geocoder.reverseGeocodeLocation(CLLocation(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: long)!)) { (placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first {
                        completion(.success(placemark))
                    } else {
                        completion(.failure(LocationFetchingError.error(error!)))
                    }
                }
                
            }
        }
    }
}
