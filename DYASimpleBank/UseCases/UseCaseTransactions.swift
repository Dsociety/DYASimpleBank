//
//  UseCaseTransactions.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation


final class UseCaseTransaction: UseCaseTrasactionsProtocol{
    
    func fetchTrasactions() async throws -> [Transaction] {
        
        let repository = CodeChallengeTransactionRepository()
        
        do{
            //RetriveList
            let list = try await repository.list()
            
            //Transaction is Hashable for ID
            //Order from highest to lowest
            //Delete with Set duplicate(inverse search)
            //Order Again
            
            let listSorted = list.sorted {$0.date > $1.date}
            let listClean = Array(Set(listSorted))
            
            let listSortedClean = listClean.sorted {$0.date > $1.date}
            return listSortedClean
            
        }catch(let error){
            //TODO: Add error casting
            throw DomainError.unknown("\(error)")
        }
        
    }
}


//        let urlSession = URLSession.shared
//        let url = URL(string: APIconstant.baseURL)
//        let (data, _) = try await urlSession.data(from: url!)
//        do{
//            return try JSONDecoder().decode([Transaction].self, from: data)
//        }catch {
//
//            print(error)
//            print("Error decode\(error.localizedDescription)")
//
//            throw DomainError.unknown("Decode")
//        }
