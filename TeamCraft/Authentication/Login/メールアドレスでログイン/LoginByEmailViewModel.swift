//
//  LoginByEmailViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class LoginByEmailViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorOccured = false
    @Published var errorMessage = ""
    func TryLogin(){
        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
            self.ShowError_or_Finish(error: error)
        }
    }
    func ShowError_or_Finish(error: (any Error)?){
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code){
                errorOccured = true
                switch errorCode {
                case .invalidEmail:
                    errorMessage = "無効なメールアドレスです"
                    print("無効なメールアドレスです")
                case .wrongPassword:
                    errorMessage = "パスワードが間違っています"
                default:
                    errorMessage = "エラーが発生しました。お問い合わせください"
                    print("その他のエラーが発生しました")
                }
            }
        } else {
            print("ログインに成功しました")
        }
    }
}



