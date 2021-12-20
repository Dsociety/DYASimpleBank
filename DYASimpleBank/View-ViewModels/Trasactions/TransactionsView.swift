//
//  ContentView.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject private var viewModel = TransactionsViewModel(
        useCase: UseCaseTransaction())
    
    var body: some View {
        
        NavigationView {
            switch viewModel.state {
            case .success(let trasactions):
                VStack(alignment: .center){
                    TransactionsListView(transactions: trasactions)
                        .navigationTitle(Text("Transaction.title"))
                }
            case .loading:
                VStack(spacing: 10){
                    LoadingView(text: "Transaction.loading")
                }
            default:
                EmptyView()

            }
        }
        .navigationViewStyle(.stack)
        .task {
            await viewModel.getTransactions()
        }
        .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in
            
            Button("Retry"){
                Task {
                    await viewModel.getTransactions()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}


//        Group {
//            if viewModel.transactions.isEmpty {
//                VStack(spacing: 10){
//                    LoadingView(text: "Transaction.loading")
//                }
//
//            }else{
//                NavigationView{
//                    VStack(alignment: .center){
//                        TransactionsListView(transactions: viewModel.transactions)
//                        .navigationTitle(Text("Transaction.title"))
//                            .refreshable {
//                                await viewModel.getTransactions()
//                            }
//                    }
//                }
//            }
//        }
//
//    }
//
//}

//struct FirstCell: View {
//    var transaction: Transaction
//
//    var body: some View {
//        VStack(alignment: .center, spacing:1) {
//
//            HStack{
//                Text(String(format: "%.2f", transaction.amount)+" €")
//                    .primaryCell()
//            }
//            VStack(alignment: .center, spacing: 1){
//                HStack{
//                    Text("General.fee")
//                        .secondaryCell()
//                    Text(transaction.porcentFee == nil ?
//                         "0.0%" : String(format: "%.2f", abs(transaction.porcentFee!))+"%")
//                        .secondaryCell()
//                    Text("General.feeAmount")
//                        .secondaryCell()
//                    Text(transaction.porcentFee == nil ?
//                         "0.0€" : String(format: "%.2f", transaction.amountFee)+"€")
//                        .secondaryCell()
//                }
//                HStack{
//                    Text("General.total")
//                    Text(String(format: "%.2f", transaction.totalAmount)+" €")
//                        .primaryCell()
//
//                }
//                Text(transaction.date, style: .date)
//                    .lineText()
//                    .padding(.leading,120)
//
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
