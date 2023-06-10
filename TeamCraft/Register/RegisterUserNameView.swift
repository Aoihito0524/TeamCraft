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
    let registerUserNameVM = RegisterUserNameViewModel()
    var body: some View{
        VStack{
            Text("ユーザーネームを登録")
            TextField("名前を入力", text: $name)
            Button("次へ"){
                if let user = Auth.auth().currentUser {
                    registerUserNameVM.RegisterUserName(user: user, name: name)
                    finishFlag.toggle()
                }
            }
        }
    }
}
class RegisterUserNameViewModel{
    func RegisterUserName(user: User, name: String){
            let request = user.createProfileChangeRequest()
            request.displayName = name
            // 変更をFirebaseに保存
            request.commitChanges { (error) in
                if let error = error {
                    print("ユーザー名の設定に失敗しました：\(error.localizedDescription)")
                } else {
                    print("ユーザー名が設定されました：\(name)")
                }
            }
    }
}
