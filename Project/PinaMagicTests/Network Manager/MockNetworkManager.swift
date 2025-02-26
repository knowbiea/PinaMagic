//
//  MockNetworkManager.swift
//  PinaMagic
//
//  Created by Arvind on 26/02/25.
//

import XCTest
import Combine
@testable import PinaMagic

//final class MockNetworkManager: NetworkManagerType {
//    
//    var ingredients: [Ingredient] {
//        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
//            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
//                return try! JSONDecoder().decode([Ingredient].self, from: data)
//            }
//        }
//        
//        return []
//    }
//    
//    func apiModelRequest<T>(_ model: T.Type, _ endpoint: EndPoints) -> AnyPublisher<T, NetworkError> {
//        Future<T, NetworkError> { promise in
//            promise(.success(model as! T))
//        }.eraseToAnyPublisher()
//    }
//}

//final class MockNetworkManager: NetworkManagerType {
//
//    var fetchIngredients: AnyPublisher<[Ingredient], NetworkError>?
//    
//    func apiModelRequest<T: Decodable>(_ model: T.Type, _ endpoint: EndPoints) -> AnyPublisher<T, NetworkError> {
////        if T.self == [Ingredient].self, let publisher = fetchIngredients {
////            return publisher
////                .map { $0 as! T } // Cast to T
////                .mapError { $0 } // Map error to Error
////                .eraseToAnyPublisher()
////        } else {
////            // Handle other types or return an error
////            return Fail(outputType: T.self, failure: NSError(domain: "MockNetworkManager", code: 0, userInfo: nil) as! NetworkError).eraseToAnyPublisher()
////        }
//        
//        fetchIngredients?.eraseToAnyPublisher() as! AnyPublisher<T, NetworkError>
//    }
//}

final class MockNetworkManager: NetworkManagerType {
    
    var data: Data?
    var error: NetworkError?
    
    func apiModelRequest<T: Decodable>(_ model: T.Type, _ endpoint: EndPoints) -> AnyPublisher<T, NetworkError> {
        
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        if let data = data {
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { value in
                    print("Error: \(value)")
                    return NetworkError.unknown
                }
                .eraseToAnyPublisher()
        }
        
        return Fail(error: NetworkError.responseError)
            .eraseToAnyPublisher()
    }
}
