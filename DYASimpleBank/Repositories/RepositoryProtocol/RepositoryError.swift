//
//  RepositoryError.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

enum RepositoryError: Error {
    
    //Network Layer
    case noNetwork
    case badRequest
    case corruptData
    case unauthorized
    case forbidden
    case hostNotAvailable
    case internalServerError
    case unknownFromClient
    case unknown
    
    //
    case decodeDTO
}


extension RepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "There is no Internet conection"
        case .badRequest:
            return "URL is not in the correct format"
        case .corruptData:
            return "Data could not be interpreted or are they empty"
        case .unauthorized:
            return "The client is not authenticated"
        case .forbidden:
            return "The client does not have the required permissions"
        case .hostNotAvailable:
            return "Cannot connect to host"
        case .internalServerError:
            return "The server has failed"
        case .unknown:
            return "Unknown error"
        case .unknownFromClient:
            return "Unknow client error"
        case .decodeDTO:
            return "Failed to convert DTO in domain model"
        }
    }
}
