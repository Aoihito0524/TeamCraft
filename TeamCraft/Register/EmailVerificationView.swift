//
//  RegisterVerificationView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct EmailVelificationView: View{
    @Binding var finishFlag: Bool
    @Binding var backFlag: Bool
    var body: some View{
        VStack(){
            Text("認証メールを送信しました")
                .font(.largeTitle)
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
            Group{
                Text("認証メールが届かない場合は再送信ボタンを押してください")
                    .font(.body)
                Text("認証メールが届くまで時間がかかる場合があります")
                    .font(.body)
            }
            .padding(.bottom, DEVICE_HEIGHT * 0.1)
            
            Divider()
            HStack{
                Button("戻る"){
                    backFlag.toggle()
                }
                Button("再送信"){
                    SendVerification()
                }
            }
        }
        .cornerRadius(10)
        .background(Color.white)
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
