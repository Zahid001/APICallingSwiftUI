//
//  RepositoryVM.swift
//  APICalling
//
//  Created by BJIT on 6/3/23.
//

import SwiftUI

class RepositoryVM: ObservableObject {
    
    private var networkManager = NetworkManager()
    
    @Published var repoItems:[Items] = []
    
    init(){
        
    }
    
    func getItems (query:String,page:String) {
        do {
            let request = try Router.repositories(query, page).requestURL()
            networkManager.request(request) { (result: Result<RepositoryModelBase, Error>) in
                switch result {
                case .success(let repositoryModelBase):
                    print("Number of items: ", repositoryModelBase.items?.count)
                    self.repoItems += repositoryModelBase.items ?? []
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
    
}
