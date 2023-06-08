//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    enum Step{
        case register
        case registerVerification
        case finish
    }
    @State var step = Step.register
    @State var finishFlag = false
    @State var backFlag = false
    var body: some View {
        ZStack{
            switch step{
            case Step.register:
                RegisterView(finishFlag: $finishFlag)
                    .onChange(of: finishFlag){_ in
                        step = Step.registerVerification
                    }
            case Step.registerVerification:
                RegisterVelificationView(finishFlag: $finishFlag, backFlag: $backFlag)
                    .onChange(of: finishFlag){_ in
                        step = Step.finish
                    }
                    .onChange(of: backFlag){_ in
                        step = Step.register
                    }
            case Step.finish:
                Text("finished")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
