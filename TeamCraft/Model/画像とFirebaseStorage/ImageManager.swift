//
//  ImageManager.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseStorage

class ImageManager: ObservableObject{
    @Published var image: UIImage?
    @Published var imageURL: String?
    func loadImage(url: String?){
        imageURL = url
        //画像がある場合はロードする
        if let urlString = imageURL, let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    print("imageLoaded")
                }
            }.resume()
        }
    }
    func SaveImage(pngName: String = UUID().uuidString) -> StorageUploadTask?{
        if image == nil{return nil}
        let reference = Storage.storage().reference()
        let path = "\(pngName).png"
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
        imageRef.downloadURL { url, error in
            if let url = url {
                self.imageURL = url.absoluteString
            }
        }
        return uploadTask
    }
}
