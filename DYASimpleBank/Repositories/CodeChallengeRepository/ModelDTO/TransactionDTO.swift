//
//  TransactionDTO.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

struct TransactionDTO: Codable{
    let id: Int
    let date : String
    let amount: Double
    let fee: Double?
    let description: String?
}
