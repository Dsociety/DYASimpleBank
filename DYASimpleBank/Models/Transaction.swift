//
//  Transaction.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

enum TypeTransaction: Codable{
    case income, expense
}                  

struct Transaction: Identifiable, Codable{
    let id: Int
    //var hashValue: Int { get {return id.hashValue} }
    
    let date : Date
    let amount: Double
    let porcentFee: Double?
    let description: String?
    
    //Calculated properties
    var typeTransaction: TypeTransaction{
        return amount.sign == .minus ? .expense : .income
    }
    var amountFee: Double {
        guard let fee = porcentFee, fee < 0 else{
            return 0
        }
        return (abs(fee) * amount / 100)
    }
    var totalAmount: Double {
        return amountFee + amount
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id, date, amount, description
        case porcentFee = "fee"
    }
    
    static func == (a: Transaction, b:Transaction) -> Bool{
        return a.id == b.id
    }
}

extension Transaction: Equatable, Hashable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Transaction{
    
    static let dummyData: [Transaction] = [
        Transaction(id: 4734, date: Date.now , amount: -193, porcentFee: -3.18, description: "Lorem ipsum dolor sit amet"),
        Transaction(id: 2210, date: Date.now , amount: 165.36, porcentFee: nil, description: "Est ullamco mollit ad in in proident."),
        Transaction(id: 1442, date: Date.now , amount:  -113.86, porcentFee: nil, description: ""),
        Transaction(id: 8396, date: Date.now , amount: -153.62, porcentFee: -3.14, description: "Quis reprehenderit ullamco incididunt non ut.")
        
    ]
}
