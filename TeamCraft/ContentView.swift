//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View{
    @State var needAuthentication = false
    @State var needRegisterSetting = false
    @State var registerSettingFinished = false //登録完了後の案内が終わるまで待つため
    @State var auth = Auth.auth()
    var body: some View{
        ZStack{
            //ユーザーがログイン済みでない
            if needAuthentication{
                AuthenticationView()
            }
            //認証と名前登録が完了していない
            else if needRegisterSetting && !registerSettingFinished{
                RegisterSettingView(finished: $registerSettingFinished)
            }
            //全部完了済み
            else{
                HomeView()
            }
        }
        .onAppear{
            auth.addStateDidChangeListener{ auth, user in
                needAuthentication = (auth.currentUser == nil)
                needRegisterSetting = !AllRegisterSettingDone()
            }
            //認証と名前登録からの場合は状況がわかりやすいようにログインからさせる。
            if auth.currentUser == nil {return;}
            if AllRegisterSettingDone(){return;}
            try? Auth.auth().signOut()
        }
    }
    func AllRegisterSettingDone() -> Bool{
        if let user = auth.currentUser{
            return user.isEmailVerified && user.displayName != nil;
        }
        return false;
    }
}
