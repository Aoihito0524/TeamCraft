//
//  RegisterSettingView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI
import FirebaseAuth

struct RegisterSettingView: View{
    struct Step{
        var step = 1
        static let back = 0
        static let emailVerification = 1
        static let emailVerificationFinish = 2
        static let registerName = 3
        static let showFinish = 4
        static let finish = 5
        enum progress{
            case Back
            case Continue
            case Finish
        }
        mutating func goNext(){
            step += 1
        }
        mutating func goBack(){
            step -= 1
        }
        func GetProgress() -> progress{
            if step == Step.finish{ //終了時
                return progress.Finish
            }
            else if step == Step.back{ //キャンセル時
                return progress.Back
            }
            return progress.Continue
        }
    }
    //工程を表す
    @State var step = Step()
    //次へと戻るに対応するフラグ
    @State var finishFlag = false
    @State var backFlag = false
    //全工程が完了した時のフラグ
    @Binding var finished: Bool
    @State var user = Auth.auth().currentUser!
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            switch step.step{
            case Step.emailVerification:
                EmailVelificationView(finishFlag: $finishFlag, backFlag: $backFlag)
            case Step.emailVerificationFinish:
                EmailVerificationFinishView(finishFlag: $finishFlag)
            case Step.registerName:
                RegisterUserNameView(finishFlag: $finishFlag)
            case Step.showFinish:
                RegisterFinishView(finishFlag: $finishFlag)
            default:
                EmptyView()
            }
        }
        .onChange(of: finishFlag){_ in
            step.goNext()
        }
        .onChange(of: backFlag){_ in
            step.goBack()
        }
        .onChange(of: step.GetProgress()){ progress in
            if progress == Step.progress.Finish{
                finished = true
            }
            if progress == Step.progress.Finish{
                //Change@later 認証画面から戻るとログイン・レジスター画面に戻る
            }
        }
        .onAppear{
            if !user.isEmailVerified{return;}
            step.step = Step.registerName
            if (user.displayName == nil){return;}
            step.step = Step.finish
        }
    }
}
