//
//  Binding+Extension.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
