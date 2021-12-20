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
        
        //If url is bad building, return badrequest
        guard let url = URL(string: requestData.path)else{
            throw NetWorkError.badRequest
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        //configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(configuration: configuration)
        
        do {
            let (data, response) = try await session.data(from: url)
            
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
            
            print("Retrive data \(data)",type: .fault)
            return data
   
        }catch(let error){
            
            print("Error de conexión: \(error),",type: .error)
            
            throw NetWorkError.unknownFromClient
        }
    }
    

    
}
