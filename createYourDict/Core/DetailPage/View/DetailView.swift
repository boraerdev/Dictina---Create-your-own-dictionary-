//
//  DetailView.swift
//  createYourDict
//
//  Created by Bora Erdem on 27.07.2022.
//

import SwiftUI

struct DetailView: View {
    @Environment (\.presentationMode) var presentationMmode
    @State var favClicked: Bool = false
    @EnvironmentObject var cd: CoreData
    @State var pickerSelecting: Int = 0
    @Binding var data: Word?
    var body: some View {
        ZStack {
            VStack{
                headerImage
                VStack{
                    titles
                    
                    groupBoxs
                    .padding()
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(false)
            .navigationTitle(data?.name ?? "")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton
                }
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    favButton
                }
            }
        }
        .onAppear {
            if ((data?.fav) != false){
                favClicked = true
            }
        }
    }
}

extension DetailView {
    
    private var favButton: some View {
            Button {
                
                favClicked.toggle()
                
                if favClicked{
                    cd.addFav(data: data!)
                } else {
                    cd.removeFav(data: data!)
                    
                }
                
                
            } label: {
                HStack{
                    Image(systemName: favClicked ? "heart.fill" :  "heart")
                        .foregroundColor(.white)
                        .font(.title)
                
                        
                }
                .padding()
                .background(Circle()
                    .foregroundColor(.red))
                .padding()
            }
    }
    
    private var headerImage : some View {
        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .foregroundColor(.blue)
            .scaleEffect(2)
            .offset(x: 10, y: -70)
    }
    
    private var titles: some View {
        VStack{
            Text(data?.name ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            HStack{
                Image(systemName: "ear.and.waveform")
                    .foregroundColor(.secondary)
                Text(data?.pronantation ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }

        }
        
    }
    
    private var groupBoxs : some View {
        VStack {
            GroupBox() {
                    
                    Text(data?.definition ?? "")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                        .overlay(
                            Image(systemName: "info")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.blue)
                        )
            }
            GroupBox {
                Text(data?.examples ?? "")
                    .multilineTextAlignment(.center)
            } label: {
                HStack{
                    Spacer()
                    Text("Examples")
                        .padding(8)
                    Spacer()
                }
                
            }
            

        }
    }
    
    private var editButton: some View {
        Menu {
            Button {
                presentationMmode.wrappedValue.dismiss()
                cd.deleteDataFromEntity(entity: data!)
            } label: {

                Label("Delete", systemImage: "trash")
                    .foregroundColor(.red)
                
            }
            Button {
                //
            } label: {
                Label("Edit", systemImage: "pencil")
            }


        } label: {
            Label {
                Text("Edit")
            } icon: {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .foregroundColor(.black)
            }

        }

        
    }
    
}
