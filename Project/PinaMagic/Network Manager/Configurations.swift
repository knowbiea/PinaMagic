//
//  Configurations.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import Foundation

struct Configuration {
    
    enum Environment: String {
        case staging = "staging"
        case production = "production"
        
        var baseURL: String {
            switch self {
            case .staging: return "https://dummyjson.com/" 
            case .production: return "https://dummyjson123.com/"
            }
        }
    }
    
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            print("Configuration: \(configuration)")
            
            if configuration.contains("Development") {
                return Environment.staging
            }
        }
        
        return Environment.production
    }()
}
