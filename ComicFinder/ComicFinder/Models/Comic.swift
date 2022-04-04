//
//  Comic.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import Foundation

public struct Comic: Decodable, Identifiable {
    
    public var thumbnail: ComicImage?
    public var title: String?
    public var id: Int
    public var description: String?
    public var format: String?
}
