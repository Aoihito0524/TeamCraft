//
//  UserSymbols.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

struct UserSymbols: View{
    @State var userName = (Auth.auth().currentUser?.displayName)!
    @State var userIcon = ImageManager()
    init(){
        userIcon.loadImage(url: Auth.auth().currentUser?.photoURL?.absoluteString)
    }
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_WIDTH * 0.18, IconImage: userIcon)
                .padding(.trailing, DEVICE_WIDTH * 0.05)
            VStack(alignment: .leading){
                Text("ユーザーネーム")
                    .font(.caption)
                TextField("名前", text: $userName)
                    .font(.largeTitle)
            }
            Button("更新"){
                let user = Auth.auth().currentUser
                let request = (user?.createProfileChangeRequest())!
                request.displayName = userName
                // 変更をFirebaseに保存
                request.commitChanges { (error) in
                    if let error = error {
                        print("ユーザー名の設定に失敗しました：\(error.localizedDescription)")
                    } else {
                        print("ユーザー名が設定されました：\(self.userName)")
                    }
                }
            }
        }
    }
}
