//
//  DateExtension.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import SwiftUI

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
