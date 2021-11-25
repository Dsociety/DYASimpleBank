//
//  Colors.swift
//  DYASimpleBank
//
//  Created by Daniel yebra on 24/11/21.
//

import SwiftUI

extension Color {
    static var theme = ColorThemeSB()
}


struct ColorThemeSB{
    
    let accent = Color("OrangeSB")
    let accentSecundary = Color("TurquoiseSB")
    let accentTertiary = Color("PurpleSB")
    let text = Color.primary
    let lightText = Color.secondary
    let red = Color.red
    let green = Color.green
}
