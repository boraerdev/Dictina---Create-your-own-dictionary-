//
//  DetailView.swift
//  createYourDict
//
//  Created by Bora Erdem on 27.07.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var cd: CoreData
    @State var pickerSelecting: Int = 0
    @Binding var data: Word?
    var body: some View {
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
    }
}

extension DetailView {
    
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
            Text(data?.pronantation ?? "")
                .foregroundColor(.secondary)
                .font(.subheadline)

        }
        
    }
    
    private var groupBoxs : some View {
        VStack {
            GroupBox() {
                HStack {
                    Spacer()
                    Image(systemName: "info")
                        .foregroundColor(.blue)
                    Spacer()
                    Text(data?.definition ?? "")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            GroupBox {
                Text(data?.examples ?? "")
                    .multilineTextAlignment(.center)
            } label: {
                HStack{
                    Spacer()
                    Text("Examples 😋")
                        .padding(8)
                    Spacer()
                }
                
            }
            

        }
    }
    
    private var editButton: some View {
        Menu {
            Button {
                cd.deleteDataFromEntity(entity: data!)
            } label: {

                Label("Delete", systemImage: "trash")
                    .foregroundColor(.red)
                
            }

        } label: {
            Label {
                Text("Edit")
            } icon: {
                Image(systemName: "pencil")
                    .foregroundColor(.black)
            }

        }

        
    }
    
}
