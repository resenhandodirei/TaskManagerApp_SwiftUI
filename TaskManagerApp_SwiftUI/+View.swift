//
//  +View.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: <#T##Alignment#>)
    }
    
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: <#T##Alignment#>)
    }
}
