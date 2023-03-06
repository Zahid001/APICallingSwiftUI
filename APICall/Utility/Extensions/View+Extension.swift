//
//  View+Extension.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

struct EmptyModifier: ViewModifier {

    let isEmpty: Bool

    func body(content: Content) -> some View {
        // We have to group the views or we will get an error:
        // "Function declares an opaque return type, but has no return statements in its body from which to infer an underlying type"
        Group {
            if isEmpty {
                EmptyView()
            } else {
                content
            }
        }
    }
}

extension View {
    /// Whether the view should be empty.
    /// - Parameter bool: Set to `true` to hide the view (return EmptyView instead). Set to `false` to show the view.
    func isEmpty(_ bool: Bool) -> some View {
        modifier(EmptyModifier(isEmpty: bool))
    }
}

