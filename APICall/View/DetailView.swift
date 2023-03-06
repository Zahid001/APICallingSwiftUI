//
//  DetailView.swift
//  APICall
//
//  Created by Md Zahidul Islam Mazumder on 6/3/23.
//

import SwiftUI

struct DetailView: View {
    let item:Items
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: item.owner?.avatar_url ?? ""))
                .frame(width: 150,height: 150)
                .clipShape(Circle())
            
            VStack(alignment: .leading,spacing: 8){
                HStack{
                    Text("Owner:")
                    Text(item.owner?.login ?? "")
                }
                HStack(alignment: .top){
                    Text("Url:")
                    Text(item.url ?? "")
                }
            }
            
            
            Spacer()
        }
        .padding()
    }
}

