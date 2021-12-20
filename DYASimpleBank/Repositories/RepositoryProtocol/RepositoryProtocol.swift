//
//  RepositoryProtocol.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype T
            
    func get(id: Int) async throws -> T
    func list() async throws -> [T]
    func add(_ item: T) async throws ->()
    func delete(_ item: T) async throws ->()
    func edit(_ item: T) async throws ->()
    
}
