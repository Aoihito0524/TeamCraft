//
//  UserIcon.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/18.
//

import SwiftUI
import FirebaseAuth

struct UserIcon: View{
    let size: CGFloat
    @ObservedObject var userIcon = UserSymbols.shared.userIcon
    init(size: CGFloat){
        self.size = size
    }
    init(size: CGFloat, photoURL: String?){
        self.size = size
        userIcon = ImageManager()
        userIcon.loadImage(url: photoURL)
    }
    var body: some View{
        ZStack{
            if let image = userIcon.image{
                Image(uiImage: image)
                    .resizable()
            }
            else{
                Rectangle().fill(.black)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
