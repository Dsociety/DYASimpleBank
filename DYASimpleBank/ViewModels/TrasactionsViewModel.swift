//
//  TrasactionsViewModel.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

protocol TransactionsViewModelProtocol: ObservableObject {
    func getTransactions() async
}

@MainActor
final class TransactionsViewModel: TransactionsViewModelProtocol {
    
    @Published private(set) var transactions: [Transaction] = []
    
    private let useCase: UseCaseTrasactionsProtocol
    
    init(useCase: UseCaseTrasactionsProtocol = UseCaseTransaction()){
        self.useCase = useCase
    }
    
    func getTransactions() async {
        do{
            let transaction = try await useCase.fetchTrasactions()
            print("transaction",type: .notice)
            self .transactions = transaction
        }catch (let error) {
            //HandleError
            print(error)
            fatalError()
        }
            
    }
    
    
    
}
