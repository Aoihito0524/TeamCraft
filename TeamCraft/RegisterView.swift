//
//  LoginView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var errorOccured = false
    @Binding var finishFlag: Bool
    @State var errorMessage = ""
    var body: some View{
        VStack{
            Text("アカウントの登録")
            if errorOccured{
                Text(errorMessage)
            }
            TextField("メールアドレス", text: $email)
            PasswordField(password: $password)
            Button("次へ"){
                //認証の途中で戻ってきた場合の対処
                if let user = Auth.auth().currentUser{//アカウントがある場合
                    finishFlag.toggle()
                    return;
                }
                //新規登録
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    ShowError_or_Finish(error: error)
                }
            }
        }
    }
    func ShowError_or_Finish(error: (any Error)?){
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code){
                errorOccured = true
                switch errorCode {
                case .invalidEmail:
                    errorMessage = "無効なメールアドレスです"
                    print("無効なメールアドレスです")
                case .emailAlreadyInUse:
                    errorMessage = "既に存在するメールアドレスです"
                    print("既に存在するメールアドレスです")
                default:
                    errorMessage = "エラーが発生しました。お問い合わせください"
                    print("その他のエラーが発生しました")
                }
            }
        } else {
            finishFlag = true
            print("新規登録に成功しました")
        }
    }
}
struct PasswordField: View{
    @Binding var password: String
    @State var visible = false
    var body: some View{
        ZStack(alignment: .trailing) {
            TextField("パスワード", text: $password)
                .opacity(visible ? 1 : 0)
            SecureField("パスワード", text: $password)
                .opacity(visible ? 0 : 1)
            Button(action: {
                visible.toggle()
            }, label: {
                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                    .padding()
                    .font(.system(size: 15))
                
            })
        }
    }
}
