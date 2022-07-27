//
//  Hview.swift
//  createYourDict
//
//  Created by Bora Erdem on 27.07.2022.
//

import SwiftUI

struct Hview: View {
    var title: String
    var subt : String
    var body: some View {
        VStack{
            Divider()
            HStack{
                Text(title)
                    .fontWeight(.bold)
                Spacer()
                Text(subt)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct Hview_Previews: PreviewProvider {
    static var previews: some View {
        Hview(title: "dev", subt: "bora")
    }
}
