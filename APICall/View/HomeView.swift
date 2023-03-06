//
//  HomeView.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var repositoryVM = RepositoryVM()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("No item avaiable")
                    .isEmpty(repositoryVM.repoItems.count != 0)
                    .padding(.top,200)
                
                List(repositoryVM.repoItems,id:\.id){ item in
                    NavigationLink(item.full_name ?? "") {
                        DetailView(item: item)
                    }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
