//
//  User.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

//ユーザークラスは責務が大きくなりやすいため、このクラスはデータとその基本処理にとどめたい
//ViewModelはこのクラスではなく他のクラスからこのクラスの要素に間接的にアクセスしたい
class UserInformation: ObservableObject{
    static let shared = UserInformation()
    @Published var userId: String = ""
    @Published var joinTeamIds: [String] = []
    @Published var joinedTeamIds: [String] = []
    @Published var userIcon = ImageManager()
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
                    self.joinTeamIds = snapshot.get("joinTeamIds") as? [String] ?? []
                    self.joinedTeamIds = snapshot.get("joinedTeamIds") as? [String] ?? []
                    //画像がある場合はロードする
                    let imageURL = snapshot.get("userIconURL") as? String
                    self.userIcon.loadImage(url: imageURL)
                }
                // ?? []の方で回避しててこっち機能してないと思う
//                else{ //新規作成
//                    self.save()
//                }
            }
        }
    }
    func JoinTeam(teamId: String){
        if !joinTeamIds.contains(teamId){
            joinTeamIds.append(teamId)
        }
        if !joinedTeamIds.contains(teamId){
            joinedTeamIds.append(teamId)
        }

        save()
    }
    func Leave(teamId: String){
        //joinedTeamIdsはすぐ去ったか長居したかで変えないとダメ
        joinTeamIds.removeAll(where: {$0 == teamId})
        save()
    }
    func save(){
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser{
            let data = ["joinTeamIds": joinTeamIds, "joinedTeamIds": joinedTeamIds, "userIconURL": userIcon.imageURL] as [String : Any]
            db.collection("userInformation").document(userId).setData(data){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("ユーザー情報がセーブされました")
            }
        }
    }
    func RegisterUserIcon(){
        let uploadTask = userIcon.SaveImage()
        uploadTask.observe(.success) { _ in
            self.save()
        }
    }
}
