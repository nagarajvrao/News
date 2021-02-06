//
//  SearchBar.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    @State private var isEditing = false
 
    var body: some View {
        VStack {
            TextField("Search", text: $text)
                .padding(7)
//                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
//                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.text = ""
// 
//                }) {
//                    Text("Cancel")
//                }
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
            
            List {
                
            }
        }
    }
}
