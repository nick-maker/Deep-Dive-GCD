//
//  TaipeiData.swift
//  Deep Dive Part 3 GCD
//
//  Created by Nick Liu on 2023/5/31.
//

import Foundation

// MARK: - Welcome
struct TaipeiData: Codable {
    let result: Result
}

// MARK: - WelcomeResult
struct Result: Codable {
    let limit, offset, count: Int
    let sort: String
    let results: [ResultElement]
}

// MARK: - ResultElement
struct ResultElement: Codable {
    let id: Int
    let location, district, address, longitude: String
    let latitude: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case location, district, address, longitude, latitude
    }
}
