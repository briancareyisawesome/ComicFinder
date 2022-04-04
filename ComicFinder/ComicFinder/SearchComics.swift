//
//  SearchComics.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation

public struct SearchComics: APIRequest {
    public typealias Response = [Comic]
    
    public var resourceName: String {
        return "comics"
    }
    
    public let titleStartsWith: String?
    public let limit: Int?
    
    public init(titleStartsWith: String? = nil,
                limit: Int? = nil) {
        self.titleStartsWith = titleStartsWith
        self.limit = limit
    }
}
