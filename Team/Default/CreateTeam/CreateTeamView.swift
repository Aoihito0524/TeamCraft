//
//  CreateTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct CreateTeamView: View{
    @Binding var isCreatingTeam: Bool
    @ObservedObject var createTeamVM = CreateTeamViewModel()
    var body: some View{
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(BACKGROUND_COLOR)
                    .ignoresSafeArea()
                VStack{
                    if let message = createTeamVM.retryMessage{
                        Text(message)
                    }
                    //画像
                    Button(action: {createTeamVM.isSelectingImage = true}){
                        ZStack{
                            Rectangle().fill(Color.gray)
                            if let image = createTeamVM.teamInfo.image{
                                Image(uiImage: image)
                                    .resizable()
                            }
                        }
                        .frame(width: DEVICE_WIDTH, height: TeamInformation.ImageHeight(width: DEVICE_WIDTH))
                    }
                    .sheet(isPresented: $createTeamVM.isSelectingImage){
                        ImagePicker(image: $createTeamVM.teamInfo.image)
                    }
                    //タグ
                    NavigationLink{
                        SelectTagView(selectedTagsGroup: $createTeamVM.teamInfo.tags)
                    } label: {
                        Text("タグを選ぶ")
                    }
                    ForEach(createTeamVM.teamInfo.tags.tags){ tag in
                        HStack{
                            TagLabel(tag: tag)
                        }
                    }
                    //タイトル
                    Text("タイトル")
                    TextField("タイトルを入力", text: $createTeamVM.teamInfo.title)
                    //概要
                    HStack{
                        Text("概要")
                        Text("（検索には影響しません）")
                    }
                    TextField("概要を入力", text: $createTeamVM.teamInfo.description)
                    Button(
                        action: {
                            if createTeamVM.teamInfo.title == ""{
                                createTeamVM.retryMessage = "タイトルを入力してください"
                                return;
                            }
                            else if createTeamVM.teamInfo.description == ""{
                                createTeamVM.retryMessage = "概要を入力してください"
                                return;
                            }
                            else if createTeamVM.teamInfo.tags.tags.count == 0{
                                createTeamVM.retryMessage = "タグは一つ以上設定してください"
                                return;
                            }
                            createTeamVM.CreateTeam()
                            isCreatingTeam = false
                        }
                    ){
                        Text("決定")
                    }
                }
            }
        }
    }
}

struct TopBar_CreateTeamView: View{
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            Text("チームを作成")
                .font(.title)
                .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}

class CreateTeamViewModel: ObservableObject{
    //Model
    @Published var teamInfo = TeamInformation()
    @Published var isSelectingImage = false
    //
    @Published var retryMessage: String?
    func CreateTeam(){
        teamInfo.register()
        UserInformation.shared.JoinTeam(teamId: teamInfo.teamId)
    }
}
