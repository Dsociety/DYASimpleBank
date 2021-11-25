//
//  NetworkServicesError.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

protocol NetWorkErrorProtocol : Error {
    var message: String { get }
}

enum NetWorkError: NetWorkErrorProtocol {

    case noNetwork
    case badRequest
    case corruptData
    case unauthorized
    case forbidden
    case hostNotAvailable
    case internalServerError
    case unknownFromClient
    case statusCode(String)
    case unknown
    
    var message: String {
        switch self {
        case.statusCode(let msg):
            return "\(self.errorDescription ?? ":")+\(msg)"
        default:
            return self.errorDescription ?? ""
        }
    }
}


extension NetWorkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "There is no Internet conection"
        case .badRequest:
            return "URL is not in the correct format"
        case .corruptData:
            return "Data could not be interpreted"
        case .unauthorized:
            return "The client is not authenticated"
        case .forbidden:
            return "The client does not have the required permissions"
        case .hostNotAvailable:
            return "Cannot connect to host"
        case .internalServerError:
            return "The server has failed"
        case .statusCode:
            return "Request error:"
        case .unknown:
            return "Unknown error"
        case .unknownFromClient:
            return "Unknow client error"
        }
    }
}
