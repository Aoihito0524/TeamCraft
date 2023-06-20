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
    @ObservedObject var VM = EmailVerificationViewMode()
    var body: some View{
        VStack(){
            Text("認証メールを送信しました")
                .font(.title)
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
            Group{
                Text("認証メールが届かない場合は再送信ボタンを押してください")
                    .font(.caption)
                Text("認証メールが届くまで時間がかかる場合があります")
                    .font(.caption)
            }
            .padding(.bottom, DEVICE_HEIGHT * 0.03)
            
            Divider()
            HStack(spacing: DEVICE_WIDTH * 0.3){
                Button("戻る"){
                    backFlag.toggle()
                }
                .font(.title2)
                .accentColor(Color.black)
                Button("再送信"){
                    VM.SendVerification()
                }
                .font(.title2)
                .accentColor(Color.black)
            }
            .frame(height: DEVICE_HEIGHT * 0.08)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
        .onAppear{
            if !(Auth.auth().currentUser?.isEmailVerified)!{
                VM.SetTimer_forCheckIsVerified(onVerified: {finishFlag.toggle()})
                VM.SendVerification()
            }
        }
    }
}
