//
//  AuthenticationView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/27.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View{
    @ObservedObject var VM: AuthenticationViewModel
    @Binding var needAuthentication: Bool
    init(needAuthentication: Binding<Bool>){
        self._needAuthentication = needAuthentication
        VM = AuthenticationViewModel(needAuthentication: needAuthentication)
    }
    var body: some View{
        ZStack{
            //ユーザーがログイン済みでない
            if VM.needRegisterLogin{
                RegisterLoginView()
            }
            //認証と名前登録が完了していない
            else if VM.needRegisterSetting && !VM.registerSettingFinished{
                RegisterSettingView(finished: $VM.registerSettingFinished)
            }
        }
        .onAppear{
            needAuthentication = VM.needAuthentication
            VM.SetListener_WhenAuthChanged()
            VM.Logout_WhenNotAllSettingFinished()
        }
        .onChange(of: VM.needAuthentication){ newValue in
            needAuthentication = VM.needAuthentication
            print("Changed")
        }
    }
}
