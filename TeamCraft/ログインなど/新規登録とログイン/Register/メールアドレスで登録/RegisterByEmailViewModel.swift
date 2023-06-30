//
//  RegisterByEmailViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class RegisterByEmailViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var password_reenter: String = ""
    @Published var errorOccured = false
    @Published var errorMessage = ""
    func TryRegister(){
        if password != password_reenter{
            errorMessage = "同じパスワードを入力してください"
            return;
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            self.ShowError_or_Finish(error: error)
        }
    }
    private func ShowError_or_Finish(error: (any Error)?){
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code){
                errorOccured = true
                switch errorCode {
                case .invalidEmail:
                    errorMessage = "無効なメールアドレスです"
                    print("無効なメールアドレスです")
                case .emailAlreadyInUse:
                    errorMessage = "既に存在するメールアドレスです"
                    print("既に存在するメールアドレスです")
                default:
                    errorMessage = "エラーが発生しました"
                    print("その他のエラーが発生しました")
                }
            }
        } else {
            print("ログインに成功しました")
        }
    }
}
