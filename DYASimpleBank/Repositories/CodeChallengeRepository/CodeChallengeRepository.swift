//
//  RepositoryCodeChallenge.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation
import SwiftUI


struct CodeChallengeTransactionRepository: RepositoryProtocol {
    typealias T = Transaction
    var networkServiceManager: NetworkServicesProtocol = NetworkServicesManager()
    
    func list() async throws -> [Transaction] {
        
        var requestData = RequestData()
        requestData.path = APIconstant.baseURL
        do{
            //Var for return
            var transactionList: [Transaction] = []
            
            //Convert the DTO into the domain model
            let data = try await networkServiceManager.request(requestData)
            let dtoList = try JSONDecoder().decode([TransactionDTO].self, from: data)
            
            for dto in dtoList{
                
                //Config Formatter to iso8601 extend
                let iso8601 = ISO8601DateFormatter()
                iso8601.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                
                //If Date is dont valid, dont save
                if let date = iso8601.date(from: dto.date){
                    let transactionModel = Transaction(id: dto.id,
                                                       date: date,
                                                       amount: dto.amount,
                                                       porcentFee: dto.fee,
                                                       description: dto.description)
                    
                    transactionList.append(transactionModel)
                    
                }else{
                    //TODO: Send logger
                    print("Wrong date, dont save",type: .notice)
                }
            }
            //Success
            return transactionList
            
        }catch( _ ){
            
            //TODO: Cast the errors to RepositoryErrors (let error)
            throw RepositoryError.unknown
        }
    }
    
    
    func get(id: Int) async throws -> Transaction {
        throw RepositoryError.forbidden
    }
    
    
    func add(_ item: Transaction) async throws {
        throw RepositoryError.forbidden
    }
    
    
    func delete(_ item: Transaction) async throws {
        throw RepositoryError.forbidden
    }
    
    
    func edit(_ item: Transaction) async throws {
        throw RepositoryError.forbidden
    }

    
    
    
}

