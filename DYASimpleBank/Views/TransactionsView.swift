//
//  ContentView.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject private var viewModel = TransactionsViewModel()
    
    var body: some View {
        
        Group {
            if viewModel.transactions.isEmpty {
                VStack(spacing: 10){
                    LoadingView(text: "Transaction.loading")
                }
                
            }else{
                NavigationView{
                    VStack(alignment: .center){
                        TransactionsListView(transactions: viewModel.transactions)
                        .navigationTitle(Text("Transaction.title"))
                            .refreshable {
                                await viewModel.getTransactions()
                            }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            await viewModel.getTransactions()
            }
    }
    
}

struct FirstCell: View {
    var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .center, spacing:1) {
         
            HStack{
                Text(String(format: "%.2f", transaction.amount)+" €")
                    .primaryCell()
            }
            VStack(alignment: .center, spacing: 1){
                HStack{
                    Text("General.fee")
                        .secondaryCell()
                    Text(transaction.porcentFee == nil ?
                         "0.0%" : String(format: "%.2f", abs(transaction.porcentFee!))+"%")
                        .secondaryCell()
                    Text("General.feeAmount")
                        .secondaryCell()
                    Text(transaction.porcentFee == nil ?
                         "0.0€" : String(format: "%.2f", transaction.amountFee)+"€")
                        .secondaryCell()
                }
                HStack{
                    Text("General.total")
                    Text(String(format: "%.2f", transaction.totalAmount)+" €")
                        .primaryCell()
                      
                }
                Text(transaction.date, style: .date)
                    .lineText()
                    .padding(.leading,120)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
