//
//  TransactionsView.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

struct TransactionsListView: View {
    @StateObject private var viewModel = TransactionsViewModel(
        useCase: UseCaseTransaction())
    
    var transactions: [Transaction] = []
    
    var body: some View {
  
        List{
            Section(header: Text("Transaction.lastTransaction")){
                if let transactionF = transactions.first{
                    TransactionCell(transaction: transactionF)
                }
            }
            let transactionRmvFrst = transactions.dropFirst()
            ForEach(transactionRmvFrst){ transaction in
                TransactionCell(transaction: transaction)
            }
        }.refreshable {
            await viewModel.getTransactions()
        }
    }
}


struct TransactionCell: View {
    var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack{
                //TODO: Get a Date transaction.date
                Text(transaction.date, style: .date)
                    .secondaryCell()
                    .padding(.top, -5)
                    .padding(.leading, -10)
                Spacer()
                Text(transaction.typeTransaction == .expense ?
                     "General.expense" : "General.income")
                    .lineText()
                imageBadged(typeTransaction: transaction.typeTransaction)
            }
            Spacer()
            HStack{
                Text(String(format: "%.2f", transaction.amount)+" €")
                    .primaryCell()
                Spacer()
                HStack{
                    Text("General.total")
                    Text(String(format: "%.2f", transaction.totalAmount)+" €")
                        .primaryCell()
                }
                .padding(.top,10)
            }
            VStack(alignment: .leading, spacing: 1){
                HStack{
                    Text("General.fee")
                        .secondaryCell()
                    Text(transaction.porcentFee == nil ?
                         "0.0%" : String(format: "%.2f", abs(transaction.porcentFee!))+"%")
                        .secondaryCell()
                }
                HStack{
                    Text("General.feeAmount")
                        .secondaryCell()
                    Text(transaction.porcentFee == nil ?
                         "0.0€" : String(format: "%.2f", transaction.amountFee)+"€")
                        .secondaryCell()
                }
            }
        }.padding(10)
    }
}


func imageBadged(typeTransaction: TypeTransaction) -> some View{
    let color = typeTransaction == .expense ? Color(.systemRed) : Color(.systemGreen)
    let image = Image(systemName: "circle.fill") //System SF.Font
        .foregroundColor(color)
        .font(.system(size: 12))
    return image
}
                                  

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView()
    }
}
