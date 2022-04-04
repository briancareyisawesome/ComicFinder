//
//  APIRequest.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var resourceName: String { get }
}
