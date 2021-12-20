//
//  ViewErrors.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 25/11/21.
//

import Foundation

protocol ViewErrorProtocol : Error {
    var message: String { get }
}

enum ViewError: ViewErrorProtocol{

    case noNetwork
    case sessionExpired
    case serverError(String)
    case internalError(String)
    case unknown(String)
    
    var message: String {
            switch self {
            case .noNetwork,.sessionExpired :
                return self.errorDescription ?? ""
            case .serverError(let msg), .internalError(let msg),
                .unknown(let msg):
                
                return "\(self.errorDescription ?? ":")+\(msg)"
            }
    }
}


extension ViewError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "There is no Internet conection"
        case .sessionExpired:
            return "The session is expired"
        case .serverError:
            return "An error occurred on the server"
        case .internalError:
            return "An internal error has occurred"
        case .unknown:
            return "Unknown error"
        }
    }
    
}
