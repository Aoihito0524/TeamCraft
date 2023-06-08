//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    enum Step{
        case registerEmail
        case emailVerification
        case emailVerificationFinish
        case registerName
        case finish
    }
    //工程を表す
    @State var step = Step.registerEmail
    //次へと戻るに対応するフラグ
    @State var finishFlag = false
    @State var backFlag = false
    //全工程が完了した時のフラグ
    @State var RegisterFinished = false
    var body: some View {
        ZStack{
            switch step{
            case .registerEmail:
                RegisterEmailView(finishFlag: $finishFlag)
                    .onChange(of: finishFlag){_ in
                        step = .emailVerification
                    }
            case .emailVerification:
                EmailVelificationView(finishFlag: $finishFlag, backFlag: $backFlag)
                    .onChange(of: finishFlag){_ in
                        step = .emailVerificationFinish
                    }
                    .onChange(of: backFlag){_ in
                        step = .registerEmail
                    }
            case .emailVerificationFinish:
                EmailVerificationFinishView(finishFlag: $finishFlag)
                    .onChange(of: finishFlag){_ in
                        step = .registerName
                    }
            case .registerName:
                RegisterUserNameView(finishFlag: $finishFlag)
                    .onChange(of: finishFlag){_ in
                        step = .finish
                    }
            case .finish:
                RegisterFinishView(RegisterFinished:$RegisterFinished)
            }
        }
    }
}
