//
//  RegisterSettingView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI
import FirebaseAuth

struct RegisterSettingView: View{
    @Binding var finished: Bool
    @ObservedObject var VM = RegisterSettingViewModel()
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            switch VM.step.step{
            case RegisterSettingStep.emailVerification:
                EmailVelificationView(finishFlag: $VM.finishFlag, backFlag: $VM.backFlag)
            case RegisterSettingStep.emailVerificationFinish:
                EmailVerificationFinishView(finishFlag: $VM.finishFlag)
            case RegisterSettingStep.registerName:
                RegisterUserNameView(finishFlag: $VM.finishFlag)
            case RegisterSettingStep.showFinish:
                RegisterFinishView(finishFlag: $VM.finishFlag)
            default:
                EmptyView()
            }
        }
        .onChange(of: VM.finishFlag){_ in
            VM.goNextStep()
        }
        .onChange(of: VM.backFlag){_ in
            VM.goBackStep()
        }
        .onChange(of: VM.StepProgress()){ progress in
            if progress == RegisterSettingStep.progress.Finish{
                finished = true
            }
            if progress == RegisterSettingStep.progress.Finish{
                //Change@later 認証画面から戻るとログイン・レジスター画面に戻る
            }
        }
        .onAppear{
            if !VM.user.isEmailVerified{return;}
            VM.step.step = RegisterSettingStep.registerName
            if (VM.user.displayName == nil){return;}
            VM.step.step = RegisterSettingStep.finish
        }
    }
}
