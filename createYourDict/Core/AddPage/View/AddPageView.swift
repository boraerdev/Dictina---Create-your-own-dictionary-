//
//  AddPageView.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import SwiftUI

struct AddPageView: View {
    @State var name: String = ""
    @State var pronunciation: String = ""
    @State var definition: String = ""
    @State var examples: String = ""
    @State var saveClicked: Bool = false
    
    @EnvironmentObject var cd: CoreData
    

    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            xmark
            .padding(30)
            sectionView
            
            Spacer()
                
        }
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView()
            
    }
}
extension AddPageView {

    private var xmark: some View {
        HStack{
            Spacer()
            Image(systemName: "xmark")
                .font(.title2)
                .foregroundColor(.blue)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }

    }
    
    private var saveButton: some View {
        Button {
            
            cd.addData(name: name, pronantation: pronunciation, definition: definition, examples: examples)
            
            saveClicked.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                presentationMode.wrappedValue.dismiss()
            }
            
        } label: {
            HStack{
                Image(systemName: saveClicked ? "checkmark" : "plus")
                    .foregroundColor(.white)
                    .font(.title)
                Text("Save")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    
            }
            .padding()
            .background(Capsule()
                .foregroundColor(saveClicked ? .green :  .blue))
            .padding()
        }
    }
    
    private var sectionView: some View {
        Section("About Your Word") {
            GroupBox(){
                textField(title: "Name", name: $name)
                    .padding()
                Divider()
                textField(title: "Pronunciation", name: $pronunciation)
                    .padding()
                Divider()
                textField(title: "Definition", name: $definition)
                    .padding()
                Divider()
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $examples)
                        .background(.red)
                        .cornerRadius(5)
                    if examples == "" {
                        Text("Examples")
                            .padding(.top,8)
                            .padding(.leading)
                            .foregroundColor(.secondary.opacity(0.5))
                            
                    }
                }.frame(height: 200)
                saveButton

                
            }.padding()
        }
    }
    
}

struct textField: View {
    var title: String
    @Binding var name: String
    var body: some View {
        VStack(spacing:0){
            TextField(title, text: $name)
        }
    }
}
