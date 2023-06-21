//
//  teamCommunication.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class TeamCommunication: ObservableObject{
    @Published var teamId: String
    @Published var messages = [messageDataType]()
    @Published var teamMemberRole = [(String, String)]()
    let teamCommunicationRef: DocumentReference
    init(teamId: String) {
        self.teamId = teamId
        let db = Firestore.firestore()
        teamCommunicationRef = db.collection("teamCommunication").document(teamId)
        //メッセージ以外取得
        teamCommunicationRef.getDocument(){ snapshot, error in
            //データがあった場合
            if let snapshot = snapshot, snapshot.exists{
                let data = (snapshot.data())!
                let dic = data["teamMemberRole"] as! [String: String]
                self.teamMemberRole = dic.map{($0.key, $0.value)}
            }
            else{ //新規作成
                self.Save()
            }
        }
        //メッセージのリアルタイム取得処理
        let messageCollection = teamCommunicationRef.collection("messages")
        messageCollection.addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges {
                    //追加された場合。メッセージは追加(・削除)のみ
                    if i.type == .added {
                        let userName = i.document.get("userName") as? String ?? ""
                        let message = i.document.get("message") as! String
                        let createdAt = i.document.get("createAt", serverTimestampBehavior: .estimate) as! Timestamp
                        let createDate = createdAt.dateValue()
                        let id = i.document.documentID

                        self.messages.append(messageDataType(teamId: teamId, userName: userName, message: message, createAt: createDate))
                    }
                }
                // 日付順に並べ替えする
                self.messages.sort { before, after in
                    return before.createAt < after.createAt ? true : false
                }
            }
        }
    }
    func Join(role: String, teamInfo: TeamInformation){
        teamMemberRole.append((UserInformation.shared.userId, role))
        teamInfo.Join(role: role)
        Save()
        UserInformation.shared.JoinTeam(teamId: teamId)
    }
    func AddMessage(message: String , user: String) {
        let data = [
            "message": message,
            "userName": user,
            "createAt":FieldValue.serverTimestamp(),
        ] as [String : Any]
        
        let db = Firestore.firestore()
        
        teamCommunicationRef.collection("messages").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("メッセージが追加されました")
        }
    }
    private func Save(){
        let data = [
            "teamMemberRole": Dictionary(uniqueKeysWithValues: teamMemberRole), //辞書にして保存
        ]
        teamCommunicationRef.setData(data){_ in}
    }
}

struct messageDataType {
    var teamId: String
    var userName: String
    var message: String
    var createAt: Date
}

class MemberManager: ObservableObject{
    @Published var AlreadyAccessed_MemberIdList = [String]()
    @Published var data = [String: String]() //id:  name,
    func GetMemberName(id: String)-> String{
        if !AlreadyAccessed_MemberIdList.contains(id){
            let db = Firestore.firestore()
            let document = db.collection("userInformation").document(id)
            document.getDocument(){snapshot, error in
                let data = (snapshot?.data())!
                let userName = data["userName"] as! String
                self.data[id] = userName
            }
        }
        return data[id]!
    }
}
