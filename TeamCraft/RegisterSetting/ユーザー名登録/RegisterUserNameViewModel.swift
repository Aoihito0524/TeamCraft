//
//  RegisterUserNameViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class RegisterUserNameViewModel: ObservableObject{
    @Published var name = ""
    @Published var isSelectingImage = false
    func RegisterUserName(){
        let user = Auth.auth().currentUser
        let request = (user?.createProfileChangeRequest())!
        request.displayName = name
        // 変更をFirebaseに保存
        request.commitChanges { (error) in
            if let error = error {
                print("ユーザー名の設定に失敗しました：\(error.localizedDescription)")
            } else {
                print("ユーザー名が設定されました：\(self.name)")
            }
        }
    }
    func RegisterUserIcon(){
        UserInformation.shared.RegisterUserIcon()
    }
}
