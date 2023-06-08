//
//  RegisterVerificationView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterVelificationView: View{
    @Binding var finishFlag: Bool
    @Binding var backFlag: Bool
    var body: some View{
        VStack(){
            Text("認証メールを送信しました")
            Text("認証メールが届かない場合は再送信ボタンを押してください")
            Text("認証メールが届くまで時間がかかる場合があります")
            HStack{
                Button("戻る"){
                    backFlag.toggle()
                }
                Button("再送信"){
                    SendVerification()
                }
            }
        }
        .onAppear{
            Add_WhenEndVerification()
            SendVerification()
        }
    }
    func Add_WhenEndVerification(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let user = Auth.auth().currentUser{
                user.reload{ error in

                }
                print(user.isEmailVerified)
                if user.isEmailVerified{
                    timer.invalidate()
                    finishFlag.toggle()
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
