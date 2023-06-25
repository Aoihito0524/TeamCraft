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
    @ObservedObject var IconImage: ImageManager
    init(size: CGFloat, IconImage: ImageManager){
        self.size = size
        self.IconImage = IconImage
    }
    init(size: CGFloat){
        self.init(size: size, IconImage: ImageManager())
    }
    var body: some View{
        ZStack{
            if let image = IconImage.image{
                Image(uiImage: image)
                    .resizable()
            }
            else{
                Rectangle().fill(.black)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .onAppear{
            //init内にあるとPublishing changes from within view updates is not allowed, this will cause undefined behavior.が出るため、ここに書く
            IconImage.loadImage(url: Auth.auth().currentUser?.photoURL?.absoluteString)
        }
    }
}
