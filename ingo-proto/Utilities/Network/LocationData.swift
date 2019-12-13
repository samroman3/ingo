//
//  LocationData.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

// MARK: - LocationData
struct LocationData: Codable {
    let placeID, osmType, osmID: String?
    let licence: String?
    let lat, lon, displayName: String?
    let boundingbox: [String]?
    let importance: Double?
    let address: Address?

    enum CodingKeys: String, CodingKey {
        case placeID
        case osmType
        case osmID
        case licence, lat, lon
        case displayName
        case boundingbox, importance, address
    }
    
    static func getLocationFromData(data: Data) throws -> LocationData? {
    do {
     let info = try JSONDecoder().decode(LocationData.self, from: data)
     return info

    } catch {
        print(error)
        return nil
    }
    }
}

// MARK: - Address
struct Address: Codable {
    let houseNumber, road, neighbourhood, city: String?
    let county, state, postcode, country: String?
    let countryCode: String?

    enum CodingKeys: String, CodingKey {
        case houseNumber
        case road, neighbourhood, city, county, state, postcode, country
        case countryCode
    }
}
