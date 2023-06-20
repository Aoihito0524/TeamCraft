//
//  Team.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

//チーム作成用
class TeamInformation: ObservableObject, Identifiable{
    static func ImageHeight(width: CGFloat) -> CGFloat{
        return width * 0.2
    }
    @Published var teamId = ""
    @Published var image = ImageManager()
    @Published var title = ""
    @Published var description = ""
    @Published var tags = TagGroup()
    @Published var keywords = [String]()
    @Published var teamRoles = [(String, Int)]()
    @Published var prepareDays = 7
    //チームの最大人数
    var num_FullMember: Int{
        get{
            var num_full = 0
            teamRoles.forEach{ role, num in
                num_full += num
            }
            return num_full
        }
    }
    init(){}
    init(document: QueryDocumentSnapshot){
        let data = document.data()
        //画像以外をロードする
        title = data["title"] as! String
        description = data["description"] as! String
        tags = TagGroup(StringArray: (data["tags"] as! [String]))
        teamId = document.documentID
        teamRoles = (data["teamRoles"] as! [String: Int]).map{($0.key, $0.value)}
        prepareDays = data["prepareDays"] as! Int
        //画像がある場合はロードする
        let imageURL = data["imageURL"] as? String
        image.loadImage(url: imageURL)
    }
    func SetKeywords(){
        //descriptionはキーワードに入れない。and検索ができないからkeywordsを厳選してもらう方針
        self.keywords = []
        self.keywords += GetKeywords(string: title)
        for tagName in tags.StringArray(){
            self.keywords += GetKeywords(string: tagName)
        }
    }
    func GetKeywords(string: String) -> [String]{
        var keywords = Set<String>()
        for num in 0..<string.count - 1{
            let fromIdx = string.index(string.startIndex, offsetBy: num)
            let toIdx = string.index(string.startIndex, offsetBy: num+1)
            keywords.insert(String(string[fromIdx...toIdx]))
        }
        return Array(keywords)
    }
    func save(){
        let save_otherThanImage = { [self] in
            SetKeywords()
            let db = Firestore.firestore()
            let data = [
                "imageURL": image.imageURL,
                "title": title,
                "description": description,
                "tags": tags.StringArray(),
                "keywords": keywords,
                "teamRoles": teamRoles.map{[$0.0: $0.1]}, //辞書にして保存
                "prepareDays": prepareDays
            ] as [String : Any]
            db.collection("teamInformation").document(teamId).setData(data)
        }
        //画像がない場合
        if image.image == nil{
            save_otherThanImage()
            return;
        }
        //画像がある場合
        let uploadTask = image.SaveImage()
        uploadTask.observe(.success) { _ in
            save_otherThanImage()
        }
    }
    func register(){
        let db = Firestore.firestore()
        let ref = db.collection("teamInformation").addDocument(data: [:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        teamId = ref.documentID
        db.collection("teamCommunication").document(teamId).setData([:]){_ in }
        save()
    }
    func RoleLeft(teamCom: TeamCommunication) -> [String]{
        var roleLefts = Set(teamRoles.map{$0.0})
        let roles = teamCom.teamMemberRole.map{$0.1}
        teamRoles.forEach{(role, num) in
            let num_MembersOfRole = roles.filter { $0 == role }.count
            //満員の場合
            if num == num_MembersOfRole{
                roleLefts.remove(role)
            }
        }
        return Array(roleLefts)
    }
}
