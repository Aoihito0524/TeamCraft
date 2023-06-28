//
//  UserSymbols.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/25.
//

import SwiftUI
import FirebaseAuth

class UserSymbols: ObservableObject{
    static let shared = UserSymbols()
    @Published var userName: String
    @Published var userIcon: ImageManager
    init(){
        userName = Auth.auth().currentUser?.displayName ?? ""
        userIcon = ImageManager()
        userIcon.loadImage(url: Auth.auth().currentUser?.photoURL?.absoluteString)
    }
    func Save(){
        let uploadTask = userIcon.SaveImage(pngName: (Auth.auth().currentUser?.uid)!)
        //画像がない場合
        if uploadTask == nil{
            SaveNameAndIcon()
            return
        }
        //ある場合
        uploadTask!.observe(.success){_ in
            self.SaveNameAndIcon()
        }
    }
    private func SaveNameAndIcon(){
        let user = Auth.auth().currentUser
        let request = (user?.createProfileChangeRequest())!
        request.displayName = self.userName
        print(self.userIcon.imageURL)
        if let urlString = self.userIcon.imageURL{
            request.photoURL = URL(string: urlString)
        }
        // 変更をFirebaseに保存
        request.commitChanges { (error) in
            if let error = error {
                print("ユーザー名、アイコンの設定に失敗しました：\(error.localizedDescription)")
            } else {
                print("ユーザー名が設定されました：\(self.userName)")
                if self.userIcon == nil{return}
                print("ユーザーアイコンが設定されました")
            }
        }
    }
}
