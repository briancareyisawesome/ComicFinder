//
//  DataContainer.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation

public struct DataContainer<Results: Decodable>: Decodable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: Results
}
