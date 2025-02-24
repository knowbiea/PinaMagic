//
//  EndPoints.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI

enum EndPoints {
    case login
    case bundle(String)
    
    private var baseURL: String {
        return Configuration.environment.baseURL
    }
    
    var isShowLoader: Bool {
        switch self {
        case .login, .bundle: true
        }
    }
    
    var url: String {
        switch self {
        case .login: baseURL + "Account/Login"
        case .bundle(let file): Bundle.main.url(forResource: file, withExtension: "json")?.absoluteString ?? ""
        }
    }
}

enum APIHeader {
    static let contentType = "Content-Type"
    static let Authorization = "Authorization"
    static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
    static let applicationJson = "application/json"
    static let multipartFormData = "multipart/form-data"
}

