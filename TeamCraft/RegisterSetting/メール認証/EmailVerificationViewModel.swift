//
//  EmailVerificationViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class EmailVerificationViewMode: ObservableObject{
    func SetTimer_forCheckIsVerified(onVerified: @escaping () -> ()){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let user = Auth.auth().currentUser{
                user.reload{ error in

                }
                print(user.isEmailVerified)
                if user.isEmailVerified{
                    timer.invalidate()
                    onVerified()
                }
            }
        }
    }
    func SendVerification(){
        if let user = Auth.auth().currentUser {
            user.sendEmailVerification { (error) in
                if let error = error {
                    print("確認メールの送信に失敗しました：\(error.localizedDescription)")
                } else {
                    print("確認メールを送信しました")
                }
            }
        }
    }
}
