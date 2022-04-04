//
//  APIResponse.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation
public struct APIResponse<Response: Decodable>: Decodable {
    public let status: String?
    public let message: String?
    public let data: DataContainer<Response>?
}
