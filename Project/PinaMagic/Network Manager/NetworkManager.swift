//
//  NetworkManager.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI
import Combine

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}

protocol NetworkManagerType {
    func apiModelRequest<T: Decodable>(_ model: T.Type,
                                       _ endpoint: EndPoints) -> AnyPublisher<T, NetworkError>
}

final class NetworkManager: NetworkManagerType {
    
    // MARK: - API Calling
    func apiModelRequest<T: Decodable>(_ model: T.Type,
                                       _ endpoint: EndPoints) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: endpoint.url) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        print("URL is \(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if case .bundle(_) = endpoint {
                    return data
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { error in
                Fail(error: NetworkError.unknown)
            }
            .eraseToAnyPublisher()
    }
}
