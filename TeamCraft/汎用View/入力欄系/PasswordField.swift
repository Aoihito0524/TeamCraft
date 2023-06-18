//
//  PasswordField.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI

struct PasswordField: View{
    let message: String
    @Binding var password: String
    @State var visible = false
    var body: some View{
        ZStack(alignment: .trailing) {
            TextField(message, text: $password)
                .opacity(visible ? 1 : 0)
            SecureField(message, text: $password)
                .opacity(visible ? 0 : 1)
            Button(action: {
                visible.toggle()
            }, label: {
                Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                    .padding()
                    .font(.system(size: 15))
                
            })
        }
    }
}
