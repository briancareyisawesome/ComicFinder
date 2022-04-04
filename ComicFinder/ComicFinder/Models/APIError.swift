//
//  APIError.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation
public enum APIError: Error {
    case encoding
    case decoding
    case server(message: String)
}
