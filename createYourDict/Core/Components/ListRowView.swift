//
//  ListRowView.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import SwiftUI

struct ListRowView: View {
    @State var data: Word? = nil
    var body: some View {
        VStack(alignment: .leading){
            GroupBox(){
                HStack {
                    HStack(spacing: 15.0) {
                        Image(systemName: "swift")
                            .resizable().scaledToFit().frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading){
                            Text(data?.name ?? "")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(data?.pronantation ?? "")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            Text(data?.definition ?? "")
                                .font(.footnote)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                    NavigationLink {
                        DetailView(data: $data)
                    } label: {
                        Image(systemName: "arrow.up.left.and.arrow.down.right.circle")
                            .font(.title2)
                            .padding(8)
                            .foregroundColor(.blue)

                    }

                }
                
            }
        }
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView()
    }
}
