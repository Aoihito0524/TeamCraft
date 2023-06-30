//
//  AuthenticationViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/27.
//

import SwiftUI
import FirebaseAuth

class AuthenticationViewModel: ObservableObject{
    @Published var registerSettingFinished = false //登録完了後の案内が終わるまで待つため
    @Published var user = Auth.auth().currentUser
    @Binding var needAuthentication_Binding: Bool
    @Published var needAuthentication: Bool {
        didSet { needAuthentication_Binding = needAuthentication }
    }
    var needRegisterLogin: Bool{
        get{ return (user == nil) }
    }
    var needRegisterSetting: Bool{
        get{ return !AllRegisterSettingDone() }
    }
    init(needAuthentication: Binding<Bool>){
        self.needAuthentication = needAuthentication.wrappedValue
        self._needAuthentication_Binding = needAuthentication
    }
    
    //認証と名前登録からの場合は状況がわかりやすいようにログインからさせる。
    func Logout_WhenNotAllSettingFinished(){
        if user == nil {return;}
        if AllRegisterSettingDone(){return;}
        try? Auth.auth().signOut()
    }
    func AllRegisterSettingDone() -> Bool{
        if let user = user{
            return user.isEmailVerified && user.displayName != nil;
        }
        return false;
    }
    func SetListener_WhenAuthChanged(){
        Auth.auth().addStateDidChangeListener{ auth, user in
            self.user = user
            self.needAuthentication = self.needRegisterLogin || self.needRegisterSetting
        }
    }
}
