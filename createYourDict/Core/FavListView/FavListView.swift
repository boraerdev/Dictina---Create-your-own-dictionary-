//
//  FavListView.swift
//  createYourDict
//
//  Created by Bora Erdem on 27.07.2022.
//

import SwiftUI

struct FavListView: View {
    @StateObject var cd: CoreData = CoreData()
    var body: some View {
        VStack{
           listView
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavListView_Previews: PreviewProvider {
    static var previews: some View {
        FavListView()
    }
}

extension FavListView {
    private var listView: some View {
        List{
            ForEach(cd.favWords) { gelen in
                ListRowView(data: gelen)
                    .padding(.horizontal).padding(.vertical,8)
            }
            .onDelete(perform: cd.deleteData)
            .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(PlainListStyle())

    }
}
