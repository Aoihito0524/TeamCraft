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
    @Published var teamId = ""
    @Published var image : UIImage?
    @Published var imageURL: String?
    @Published var title = ""
    @Published var description = ""
    @Published var tags = TagGroup()
    @Published var keywords = [String]()
    init(){}
    init(data: [String: Any]){
        //画像以外をロードする
        title = data["title"] as! String
        title = data["description"] as! String
        tags = TagGroup(StringArray: (data["tags"] as! [String]))
        //画像がある場合はロードする
        imageURL = data["imageURL"] as? String
        if let urlString = imageURL, let url = URL(string: urlString){
            do {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data)!
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    func saveImage() -> (StorageUploadTask, String){
        let reference = Storage.storage().reference()
        let path = "test.png"
        let imageRef = reference.child(path)
        let imageData = image!.jpegData(compressionQuality: 1.0)! as NSData
        let uploadTask = imageRef.putData(imageData as Data, metadata: nil) { (data, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
        uploadTask.observe(.failure) { _ in
            print("画像のアップロードに失敗しました")
        }
        var urlString = ""
        imageRef.downloadURL { url, error in
            if let url = url {
                urlString = url.absoluteString
            }
        }
        return (uploadTask, urlString)
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
                "imageURL": imageURL,
                "title": title,
                "description": description,
                "tags": tags.StringArray(),
                "keywords": keywords
            ] as [String : Any]
            db.collection("teamInformation").document(teamId).setData(data)
        }
        //画像がない場合
        if image == nil{
            save_otherThanImage()
            return;
        }
        //画像がある場合
        let result = saveImage()
        let uploadTask = result.0
        imageURL = result.1
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
        save()
    }
}
