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

    //Models
    @Published private(set) var transactions: [Transaction] = []
    
    //States
    enum StateView {
        case notAvailable
        case loading
        case success(data: [Transaction])
        case failed(error: ViewError)
    }
    @Published private(set) var state: StateView = .notAvailable
    @Published var hasError: Bool = false
    
    private let useCase: UseCaseTrasactionsProtocol
    
    init(useCase: UseCaseTrasactionsProtocol = UseCaseTransaction()){
        self.useCase = useCase
    }
    
    func getTransactions() async {
        
        self.state = .loading
        self.hasError = false

        do{
            
            let transactions = try await useCase.fetchTrasactions()
            self.state = .success(data: transactions)
            
        }catch{
            
            self.hasError = true
            print("Error \(error.localizedDescription)",type: .error, filename: "TransactionViewmodel", function: "GetTransactions()")
            self.state = .failed(error: .unknown(error.localizedDescription))
           
        }
    }
    
    
    
}
