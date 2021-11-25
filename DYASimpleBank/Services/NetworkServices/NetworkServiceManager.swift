//
//  NetworkServiceManager.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

struct NetworkServicesManager: NetworkServicesProtocol{
    
    //TODO: Improve request to handler: http verbs, parameters etc
    func request(_ requestData: RequestData) async throws -> Data {
        
        guard let url = URL(string: requestData.path)else{
            throw NetWorkError.badRequest
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else{
                throw NetWorkError.unknown
            }
            if  response.statusCode != 200 {
                
                switch response.statusCode{
                case 404:
                    throw NetWorkError.badRequest
                    
                //TODO: Add server errors
                default:
                    throw NetWorkError.statusCode("\(response.statusCode)")
                }
            }
            
            return data
   
        }catch{
            throw NetWorkError.unknownFromClient
        }
    }
    

    
}
