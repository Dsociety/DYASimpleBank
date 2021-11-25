//
//  DomainErrors.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

protocol DomainLayerError : Error {
    var message: String { get }
}

enum DomainError: DomainLayerError{

    //System
    case noNetwork
    
    //Access
    case unauthorized
    case forbidden
    
    //User
    case RegexError
    
    //Internal
    case internalError(String)
    
    //External
    case conectionFailure(String)
    
    case unknown(String)
    
    var message: String {
            switch self {
            case .noNetwork,.unauthorized, .forbidden, .RegexError :
                return self.errorDescription ?? ""
            case .internalError(let msg),
                .conectionFailure(let msg),
                .unknown(let msg):
                
                return "\(self.errorDescription ?? ":")+\(msg)"
            }
    }
}


extension DomainError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "There is no Internet conection"
        case .unauthorized:
            return  "Need to login"
        case .forbidden:
            return  "Don't have the necessary permissions"
        case .RegexError:
            return "User or password does not meet type or security requirements"
        case .internalError:
            return "Something has gone wrong like, badRequest, codable, API changes not made in code ... "
        case .unknown:
            return "Unknown error"
        case .conectionFailure:
            return  "An error has occurred on the server"

        }
    }
    
}
