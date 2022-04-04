//
//  APIClient.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import Foundation

public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

public class APIClient {
    private let baseEndpointUrl = URL(string: "https://gateway.marvel.com/v1/public/")!
    private let session = URLSession(configuration: .default)

    private let publicKey: String = "857d38d90b5015b2523705aec4219297"
    private let privateKey: String = "e377707047bf588f654a24ed7d7dc3aa7d0ac270"

    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
        let endpoint = self.endpoint(for: request)

        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(APIResponse<T.Response>.self, from: data)

                    if let dataContainer = response.data {
                        completion(.success(dataContainer))
                    } else if let message = response.message {
                        completion(.failure(APIError.server(message: message)))
                    } else {
                        completion(.failure(APIError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Bad resourceName: \(request.resourceName)")
        }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!

        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\("e377707047bf588f654a24ed7d7dc3aa7d0ac270")\("857d38d90b5015b2523705aec4219297")".md5
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: "857d38d90b5015b2523705aec4219297")
        ]

        let customQueryItems: [URLQueryItem]

        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }

        components.queryItems = commonQueryItems + customQueryItems

        return components.url!
    }
}

