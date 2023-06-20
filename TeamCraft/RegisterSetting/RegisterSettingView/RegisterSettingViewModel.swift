//
//  RegisterSettingViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class RegisterSettingViewModel: ObservableObject{
    //工程を表す
    @Published var step = RegisterSettingStep()
    //次へと戻るに対応するフラグ
    @Published var finishFlag = false
    @Published var backFlag = false
    //全工程が完了した時のフラグ
    @Published var user = Auth.auth().currentUser!
    func StepProgress() -> RegisterSettingStep.progress{
        return step.GetProgress()
    }
    func goNextStep(){
        step.goNext()
    }
    func goBackStep(){
        step.goBack()
    }
}

struct RegisterSettingStep{
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
        if step == RegisterSettingStep.finish{ //終了時
            return progress.Finish
        }
        else if step == RegisterSettingStep.back{ //キャンセル時
            return progress.Back
        }
        return progress.Continue
    }
}
