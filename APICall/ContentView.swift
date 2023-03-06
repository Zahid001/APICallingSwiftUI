//
//  ContentView.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var b = RepositoryVM()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(){
            b.getItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
