//
//  RegisterUserNameViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

class RegisterUserNameViewModel: ObservableObject{
    @Published var userSymbols = UserSymbols.shared
    func Save(){
        userSymbols.Save()
    }
}
