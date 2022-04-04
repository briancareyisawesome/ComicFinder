//
//  Image.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import Foundation

public struct ComicImage: Decodable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    public let url: URL
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        let url = URL(string: "\(path).\(fileExtension)")
        
        self.url = url!
    }
}
