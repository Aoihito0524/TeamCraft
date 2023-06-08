//
//  RegisterNameView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterUserNameView: View{
    @Binding var finishFlag: Bool
    @State var name = ""
    var body: some View{
        VStack{
            Text("ユーザーネームを登録")
            TextField("名前", text: $name)
            Button("次へ"){
                if let user = Auth.auth().currentUser {
                    let req = user.createProfileChangeRequest()
                    req.displayName = name
                    finishFlag.toggle()
                }
            }
        }
    }
}
