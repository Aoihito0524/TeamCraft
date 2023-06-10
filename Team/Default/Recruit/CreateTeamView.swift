//
//  CreateTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

struct CreateTeamView: View{
    @Binding var isCreatingTeam: Bool
    @ObservedObject var info = TeamInformation()
    @State var isSelectingImage = false
    var body: some View{
        NavigationView{
            VStack{
                //画像
                Button(action: {isSelectingImage = true}){
                    ZStack{
                        Rectangle().fill(Color.gray).frame(width: DEVICE_WIDTH, height: DEVICE_WIDTH * 0.4)
                        if let image = info.image{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: DEVICE_WIDTH, height: DEVICE_WIDTH * 0.4)
                        }
                    }
                }
                .sheet(isPresented: $isSelectingImage){
                    ImagePicker(image: $info.image)
                }
                //タグ
                NavigationLink{
                    SelectTagView(tags: info.tags)
                } label: {
                    Text("タグを選ぶ")
                }
                //タイトル
                Text("タイトル")
                TextField("タイトルを入力", text: $info.title)
                //概要
                Text("概要")
                TextField("概要を入力", text: $info.description)
                Button(
                    action: {
                        info.Upload()
                        isCreatingTeam = false
                    }
                ){
                    Text("決定")
                }
            }
        }
    }
}

class TeamInformation: ObservableObject{
    @Published var image : UIImage?
    @Published var title = ""
    @Published var description = ""
    @Published var tags = TagGroup()
    func Upload(){
            let data = [
                "image": "",
                "title": title,
                "description": description,
                "tags": ""
            ] as [String : Any]
            
            let db = Firestore.firestore()
            
        db.collection("teamInformation").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("チームが作成されました")
        }
    }
}
