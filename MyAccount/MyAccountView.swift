//
//  MyAccountView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseAuth

struct MyAccountView: View{
    var body: some View{
        ZStack{
            Rectangle().fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack(spacing: 0){
                TopBar_MyAccountView()
                AccountInformationView()
                Spacer()
            }
        }
    }
}
struct TopBar_MyAccountView: View{
    var body: some View{
        HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: DEVICE_HEIGHT * 0.07, height: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            Text("アカウント")
                    .font(.title)
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}
struct AccountInformationView: View{
    @State var SelfIntroduction = "なし"
    @ObservedObject var userInformation = UserInformation.shared
    var body: some View{
        ScrollView{
            VStack(spacing: 0){
                //アイコンと名前
                HStack{
                    UserIcon(size: DEVICE_WIDTH * 0.18)
                        .padding(.trailing, DEVICE_WIDTH * 0.05)
                    VStack(alignment: .leading){
                        Text("ユーザーネーム")
                            .font(.caption)
                        Text((Auth.auth().currentUser?.displayName)!)
                            .font(.largeTitle)
                    }
                }
                .padding(.vertical, DEVICE_HEIGHT * 0.04)
                //自己紹介文
                VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.05){
                    VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
                        Text("自己紹介文")
                            .font(.caption)
                        TextField("", text: $SelfIntroduction)
                            .lineLimit(nil)
                            .frame(minHeight: DEVICE_HEIGHT * 0.1)
                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                    }
                    VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
                        Text("現在参加中のチーム")
                            .font(.caption)
                        if userInformation.joinTeamIds.count != 0{
                            Text("\(userInformation.joinTeamIds.count)チーム")
                        }
                        else{
                            Text("なし")
                        }
                    }
                    VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
                        Text("過去に参加したチーム")
                            .font(.caption)
                        if userInformation.joinedTeamIds.count != 0{
                            Text("\(userInformation.joinedTeamIds.count)チーム")
                        }
                        else{
                            Text("なし")
                        }
                    }
                    VStack{
                        Text("アカウント")
                            .font(.caption)
                        if let email = Auth.auth().currentUser?.email{
                            Text(email)
                        }
                    }
                }
                .padding(.horizontal, DEVICE_WIDTH*0.1)
                Button("ログアウト"){
                    do {
                        try Auth.auth().signOut()
                        print("ログアウトしました")
                    } catch let signOutError as NSError {
                        print("Error signing out: \(signOutError)")
                    }
                }
                .foregroundColor(Color.red)
                .padding(.top, DEVICE_HEIGHT * 0.03)
                Spacer()
            }
            .frame(minHeight: DEVICE_HEIGHT*0.9)
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
            .background(Color.white.opacity(0.82))
        }
    }
}

//struct MyAccountPreview: PreviewProvider{
//    @State static var flag = false
//    static var previews: some View{
//        MyAccountView()
//    }
//}
