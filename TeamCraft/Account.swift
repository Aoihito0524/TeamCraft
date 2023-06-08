//
//  Account.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import Foundation
import FirebaseAuth

class Account{
    static var shared = Account()
    func RegisterAccount(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let user = authResult?.user {
                print("アカウントが作成されました：\(user.uid)")
            }
            else{
                print("アカウントは作成されませんでした")
            }
        }
    }
}
