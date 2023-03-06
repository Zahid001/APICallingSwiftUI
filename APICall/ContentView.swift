//
//  ContentView.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var repositoryVM = RepositoryVM()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("No item avaiable")
                    .isEmpty(repositoryVM.repoItems.count != 0)
                
                List(repositoryVM.repoItems,id:\.id){
                    Text("\($0.full_name ?? "")")
                }
                
                Button("Load More", action: {
                    repositoryVM.loadMore()
                })
                .isEmpty(repositoryVM.repoItems.count == 0)
                
            }
            
            .navigationTitle("Search repository...")
        }
        .searchable(text: $repositoryVM.searchText.onChange({ value in
            
            repositoryVM.getItems(query: value, page: "1")
            
        }))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
