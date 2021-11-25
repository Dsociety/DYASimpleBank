//
//  Text.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

extension Text {
    
    
    func title() -> some View {
        self.foregroundColor(Color.theme.accent)
            .bold()
            .font(.system(size: 22))
    }

    
    func primaryCell() -> some View {
        self.foregroundColor(Color.theme.text)
            .font(.system(size: 16, weight: .medium))
    }
    
    
    func secondaryCell() -> some View {
        self.foregroundColor(Color.theme.lightText)
            .font(.system(size: 12,weight: .light))
    }

    
    func lineText() -> some View {
        self.foregroundColor(Color.theme.lightText)
            .font(.system(size: 8,weight: .light))
    }
}



// Then in the app you can use it as follows

//Text("What is this?").deepRedTextStyle()
