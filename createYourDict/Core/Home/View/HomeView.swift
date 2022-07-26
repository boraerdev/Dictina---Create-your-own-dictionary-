//
//  ContentView.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import SwiftUI

struct HomeView: View {
    @State var goAddPage: Bool = false
    @EnvironmentObject var cd: CoreData
    @State var schemeSelector: Bool = false
    @State var colorScheme: ColorScheme?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                listView
            }
            .sheet(isPresented: $goAddPage) {
                AddPageView()
            }
            addButton
        }
        .navigationTitle("Words")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    schemeSelector.toggle()
                    if schemeSelector{
                        colorScheme = .dark
                    }
                    else{
                        colorScheme = .light
                    }
                } label: {
                    Image(systemName: "i.circle")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .environmentObject(CoreData())
        }
    }
}

extension HomeView {
    private var addButton: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    goAddPage.toggle()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            
                    }
                    .padding()
                    .background(Capsule()
                        .foregroundColor(.blue))
                    .padding()

                }
            }
        }
    }
    
    private var listView:some View {
        List{
            ForEach(cd.words) { gelen in
                ListRowView(data: gelen).padding(.horizontal).padding(.vertical,8)
            }
            .onDelete(perform: cd.deleteData)
            .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(PlainListStyle())
    }
    
}
