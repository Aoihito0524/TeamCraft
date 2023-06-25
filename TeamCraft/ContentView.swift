//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

@MainActor
struct ContentView: View{
    @ObservedObject var VM = ContentViewModel()
    var body: some View{
        ZStack{
            //ユーザーがログイン済みでない
            if VM.needAuthentication{
                AuthenticationView()
            }
            //認証と名前登録が完了していない
            else if VM.needRegisterSetting && !VM.registerSettingFinished{
                RegisterSettingView(finished: $VM.registerSettingFinished)
            }
            //全部完了済み
            else{
                HomeView()
            }
        }
        .onAppear{
            VM.SetListener_WhenAuthChanged()
            VM.Logout_WhenNotAllSettingFinished()
        }
    }
}

class ContentViewModel: ObservableObject{
    var needAuthentication: Bool{
        get{ return (auth.currentUser == nil) }
    }
    var needRegisterSetting: Bool{
        get{ return !self.AllRegisterSettingDone() }
    }
    @Published var registerSettingFinished = false //登録完了後の案内が終わるまで待つため
    @Published var auth = Auth.auth()
    //認証と名前登録からの場合は状況がわかりやすいようにログインからさせる。
    func Logout_WhenNotAllSettingFinished(){
        if auth.currentUser == nil {return;}
        if AllRegisterSettingDone(){return;}
        try? self.auth.signOut()
    }
    func AllRegisterSettingDone() -> Bool{
        if let user = auth.currentUser{
            return user.isEmailVerified && user.displayName != nil;
        }
        return false;
    }
    func SetListener_WhenAuthChanged(){
        auth.addStateDidChangeListener{ auth, user in
            self.auth = auth
        }
    }
}
