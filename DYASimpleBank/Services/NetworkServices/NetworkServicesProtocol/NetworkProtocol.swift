//
//  NetworkProtocol.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation


protocol NetworkServicesProtocol {
    
    func request(_ requestData: RequestData) async throws -> Data
}



enum Encoding: String {
    case JSONEncoding
}


enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case delete
    case connect
    case options
    case trace
    case patch
}


struct RequestData {
    var method: HTTPMethod
    var path: String
    var parameters: [String: Any]?
    var encoding: Encoding
    var headers: [String:String]?
    
    init() {
        method = .get
        path = ""
        parameters = nil
        encoding = .JSONEncoding
        headers = ["Content-Type": "application/json",
                   "X-Requested-With": "XMLHttpRequest",
                   "Cache-Control": "no-cache"]
    }
}

