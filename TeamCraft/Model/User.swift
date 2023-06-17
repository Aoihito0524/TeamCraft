//
//  User.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

//ユーザークラスは肥大化しやすいため、このクラスはデータとその基本処理にとどめる。
//ViewModelはこのクラスではなく他のクラスからこのクラスの要素に間接的にアクセスする
class UserInformation: ObservableObject{
    static let shared = UserInformation()
    @Published var userId: String = ""
    @Published var joinTeamIds: [String] = []
    init() {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser{
            userId = user.uid
            let document = db.collection("userInformation").document(userId)
            document.getDocument(){ snapshot, error in
                if let error = error{
                    print("エラー発生: \(error.localizedDescription)")
                }
                if let snapshot = snapshot, snapshot.exists{
                    self.joinTeamIds = snapshot.get("joinTeamIds") as! [String]
                }
                else{ //新規作成
                    self.save()
                }
            }
        }
    }
    func JoinTeam(teamId: String){
        joinTeamIds.append(teamId)
        save()
    }
    func save(){
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser{
            let data = ["joinTeamIds": joinTeamIds] as [String : Any]
            db.collection("userInformation").document(userId).setData(data){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("ユーザー情報がセーブされました")
            }
        }
    }
}
