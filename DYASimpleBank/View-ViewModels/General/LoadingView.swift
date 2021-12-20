//
//  LoadingView.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

struct LoadingView: View {
    
    let text: String
    
    var body: some View {
        VStack(spacing: 10){
            ProgressView()
            Text(text)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "LOADING")
    }
}
