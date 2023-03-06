//
//  RepositoryVM.swift
//  APICalling
//
//  Created by BJIT on 6/3/23.
//

import SwiftUI

class RepositoryVM: ObservableObject {
    var dispatchWorkItem:DispatchWorkItem?
    private var networkManager = NetworkManager()
    
    @Published var page = 1
    @Published var searchText = ""
    
    @Published var repoItems:[Items] = []
    
    init(){
        
    }
    
    func loadMore(){
        page += 1
        getItems(query: searchText, page: "\(page)")
    }
    
    func getItems (query:String,page:String) {
        dispatchWorkItem?.cancel()
        
        if query.isEmpty {
            self.repoItems = []
            return
        }
        
        let requestWorkItem = DispatchWorkItem {[weak self] in
            
            do {
                let request = try Router.repositories(query, page).requestURL()
                self?.networkManager.request(request) {[weak self] (result: Result<RepositoryModelBase, Error>) in
                    switch result {
                    case .success(let repositoryModelBase):
                        if Int(page) == 1 {
                            self?.repoItems = []
                        }
                        self?.repoItems += repositoryModelBase.items ?? []
                    case .failure(let error):
                        if let error = error as? NetworkError {
                            let message = ErrorMapper(error: error).message
                            print(message)
                        } else {
                            print(error)
                        }
                    }

                }
            } catch {
                print("Errors: \(error)")
            }
        }
        
        dispatchWorkItem = requestWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(400), execute: dispatchWorkItem!)
        
    }
    
}
