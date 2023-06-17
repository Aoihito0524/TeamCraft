//
//  TeamTag.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/14.
//

import SwiftUI

struct Tag: Identifiable{
    let id = UUID()
    let tagName: String
    init(tagName: String){
        self.tagName = tagName
    }
}
//Tagは[String]の形でセーブロードするため、それを扱いやすくするための構造体
struct TagGroup: Identifiable{
    var id = UUID()
    static let allTags = [Tag(tagName: "ゲーム制作"), Tag(tagName: "アプリ制作")]
    var tags: [Tag]
    init(){
        tags = [Tag]()
    }
    init(StringArray: [String]){
        tags = StringArray.map{Tag(tagName: $0)}
    }
    func StringArray() -> [String]{
        return tags.map{$0.tagName}
    }
    func Contains(tag: Tag) -> Bool{
        return tags.map{$0.tagName}.contains(tag.tagName)
    }
}

struct TagLabel: View{
    let tag : Tag
    var body: some View{
        Text(tag.tagName)
            .background(Color.green)
            .cornerRadius(20)
    }
}
