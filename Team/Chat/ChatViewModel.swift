//
//  ChatViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

class ChatViewModel: ObservableObject{
    @Published var group = groupDataType(groupId: "")
    @Published var messages = [messageDataType]()
    init() {
        let db = Firestore.firestore()
        //リアルタイム更新処理の登録
        db.collection("messages").addSnapshotListener { (snap, error) in
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
                        
                        self.messages.append(messageDataType(groupId: self.group.groupId, id: id, userName: userName, message: message, createAt: createDate))
                    }
                }
                // 日付順に並べ替えする
                self.messages.sort { before, after in
                    return before.createAt < after.createAt ? true : false
                }
            }
        }
    }
    func AddMessage(message: String , user: String) {
        let data = [
            "groupId": group.groupId,
            "message": message,
            "userName": user,
            "createAt":FieldValue.serverTimestamp(),
        ] as [String : Any] //Any強すぎ　後で型指定してキャストするから問題なし！
        
        let db = Firestore.firestore()
        
        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("メッセージが追加されました")
        }
    }
}

struct messageDataType: Identifiable {
    var groupId: String
    var id: String
    var userName: String
    var message: String
    var createAt: Date
}

struct groupDataType{
    var groupId: String
}
