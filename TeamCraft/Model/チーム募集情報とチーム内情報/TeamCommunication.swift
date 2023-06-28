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
    @Published var teamMemberRole = [String: String]()
    let teamCommunicationRef: DocumentReference
    init(teamId: String) {
        self.teamId = teamId
        let db = Firestore.firestore()
        teamCommunicationRef = db.collection("teamCommunication").document(teamId)
        //メッセージ以外取得
        teamCommunicationRef.getDocument(){ snapshot, error in
            if let snapshot = snapshot, snapshot.exists{
                let data = (snapshot.data())!
                //アップロードしてすぐだとデータがないことがある
                if data.count != 0{
                    self.teamMemberRole = data["teamMemberRole"] as! [String: String]
                }
            }
        }
        SetListener_forUpdateMessages()
    }
    func Join(role: String, teamInfo: TeamInformation){
        teamMemberRole[UserInformation.shared.userId] = role
        teamInfo.Join(role: role)
        Save()
        UserInformation.shared.JoinTeam(teamId: teamId)
    }
    func Leave(userId: String, teamInfo: TeamInformation){
        let role = teamMemberRole[userId]
        teamMemberRole.removeValue(forKey: userId)
        teamInfo.Leave(role: role!)
        Save()
        UserInformation.shared.Leave(teamId: teamId)
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
            "teamMemberRole":  teamMemberRole,
        ]
        teamCommunicationRef.setData(data){_ in}
    }
    
    //メッセージのリアルタイム取得処理
    private func SetListener_forUpdateMessages(){
        let messageCollection = teamCommunicationRef.collection("messages")
        messageCollection.addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges {
                    //メッセージは追加(・削除)のみ
                    //追加された場合と最初のロード
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
}

struct messageDataType {
    var teamId: String
    var userName: String
    var message: String
    var createAt: Date
}

