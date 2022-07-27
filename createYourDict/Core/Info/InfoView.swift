//
//  InfoView.swift
//  createYourDict
//
//  Created by Bora Erdem on 27.07.2022.
//

import SwiftUI

struct InfoView: View {
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            xmark.padding(30)
            GroupBox("About") {
                Hview(title: "Developer", subt: "Bora Erdem")
                Hview(title: "Version", subt: "1.0")
            }.padding()
            
            GroupBox("Dictina") {
                Divider()
                Text("Dictina is a simple and useful application developed for those who want to create their own dictionary.")
            }.padding()
            Spacer()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView{
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
}
