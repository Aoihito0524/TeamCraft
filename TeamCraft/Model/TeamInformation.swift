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
    @Published var teamRolesLeft = [(String, Int)]()
    @Published var num_FullMember = 0
    @Published var prepareDays = 7
    init(){}
    //大量取得用
    init(document: QueryDocumentSnapshot){
        let data = document.data()
        teamId = document.documentID
        SetDatas(data: data)
    }
    func SetDatas(data: [String: Any]){
        title = data["title"] as! String
        description = data["description"] as! String
        tags = TagGroup(StringArray: (data["tags"] as! [String]))
        let dic = data["teamRolesLeft"] as! [String: Int]
        teamRolesLeft = dic.map{($0.key, $0.value)}
        num_FullMember = data["num_FullMember"] as! Int
        prepareDays = data["prepareDays"] as! Int
        //画像がある場合はロードする
        let imageURL = data["imageURL"] as? String
        image.loadImage(url: imageURL)
    }
    //単体取得用
    init(teamId: String){
        RetrieveData(teamId: teamId)
    }
    func RetrieveData(teamId: String){
        self.teamId = teamId
        let db = Firestore.firestore()
        db.collection("teamInformation").document(teamId).getDocument(){ snapshot, error in
            if let snapshot = snapshot, snapshot.exists{
                let data = (snapshot.data())!
                if data.count == 0{return;}
                self.SetDatas(data: data)
            }
        }
    }
    func isCompletelyLoaded() -> Bool{
        if teamId == "" { return false }
        if title == "" { return false }
        if description == "" { return false }
        return true
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
        if string == ""{return[]}
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
                "teamRolesLeft": Dictionary(uniqueKeysWithValues: teamRolesLeft),
                "num_FullMember": num_FullMember,
                "prepareDays": prepareDays
            ] as [String : Any]
            db.collection("teamInformation").document(teamId).setData(data)
        }
        let uploadTask = image.SaveImage()
        //画像がない場合
        if uploadTask == nil{
            save_otherThanImage()
            return;
        }
        //画像がある場合
        uploadTask!.observe(.success) { _ in
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
    func RoleLeft() -> [String]{
        return teamRolesLeft.map{$0.0}
    }
    func NumLeft_Member() -> Int{
        var num_full = 0
        teamRolesLeft.forEach{ role, num in
            num_full += num
        }
        return num_full
    }
    func Join(role: String){
        var dic: [String: Int] = Dictionary(uniqueKeysWithValues: teamRolesLeft)
        dic[role] = dic[role]! - 1
        if dic[role] == 0{
            dic.removeValue(forKey: role)
        }
        teamRolesLeft = dic.map{($0.key, $0.value)}
        save()
    }
    func Leave(role: String){
        var dic: [String: Int] = Dictionary(uniqueKeysWithValues: teamRolesLeft)
        if let count = dic[role]{
            dic[role] = count + 1
        }
        else{
            dic[role] = 1
        }
        teamRolesLeft = dic.map{($0.key, $0.value)}
        save()
    }
}
