//
//  UseCaseProtocol.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

protocol UseCaseTrasactionsProtocol {
    
    func fetchTrasactions() async throws -> [Transaction]
}
