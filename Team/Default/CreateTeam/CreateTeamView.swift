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
    @ObservedObject var VM = CreateTeamViewModel()
    var body: some View{
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(BACKGROUND_COLOR)
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    TopBar_CreateTeamView()
                    ScrollView{
                        VStack(alignment: .leading, spacing: DEVICE_HEIGHT * 0.05){
                            Rectangle().fill(Color.clear)
                                .frame(height: DEVICE_HEIGHT * 0.03)
                            if let message = VM.retryMessage{
                                Text(message)
                            }
                            //画像
                            SelectHeadlineImage(isSelectingImage: $VM.isSelectingImage, image: $VM.teamInfo.image.image)
                            //タイトル
                            CreateTitleTextField(titleText: $VM.teamInfo.title)
                                .padding(.leading, DEVICE_WIDTH * 0.1)
                            //タグ
                            SelectTagRow(tagGroup: $VM.teamInfo.tags)
                                .padding(.leading, DEVICE_WIDTH * 0.1)
                            //概要
                            DescriptionTextField(descriptionText: $VM.teamInfo.description)
                                .padding(.leading, DEVICE_WIDTH * 0.1)
                            //チーム作成ボタン
                            HStack{
                                Spacer()
                                CreateTeamButton(VM: VM, isCreatingTeam: $isCreatingTeam)
                                Spacer()
                            }
                            .padding(.leading, DEVICE_WIDTH * 0.1)
                            .padding(.bottom, DEVICE_HEIGHT * 0.05)
                        }
                        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
                        .background(Color.white.opacity(0.82))
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
    //全条件を満たし作成可能な場合Trueを返す
    func CanCreateTeam() -> Bool{
        if teamInfo.title == ""{
            retryMessage = "タイトルを入力してください"
            return false;
        }
        else if teamInfo.description == ""{
            retryMessage = "概要を入力してください"
            return false;
        }
        else if teamInfo.tags.tags.count == 0{
            retryMessage = "タグは一つ以上設定してください"
            return false;
        }
        return true
    }
}
