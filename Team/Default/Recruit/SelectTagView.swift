//
//  SelectTagView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct SelectTagView: View{
    @ObservedObject var tags: TagGroup
    var body: some View{
        Text("SelectTagView")
        ForEach(TagGroup.allTags){tag in
            TagButton(tag: tag, tags: tags)
        }
    }
}

class Tag: Identifiable, ObservableObject{
    let tagName: String
    @Published var isSelected = false
    init(tagName: String){
        self.tagName = tagName
    }
}
class TagGroup: Identifiable, ObservableObject{
    static let allTags = [Tag(tagName: "ゲーム制作"), Tag(tagName: "アプリ制作")]
    var tags: [Tag]
    init(){
        tags = [Tag]()
    }
    func StringArray() -> [String]{
        return tags.map{$0.tagName}
    }
    func SetTags(StringArray: [String]){
        tags = StringArray.map{Tag(tagName: $0)}
    }
}

struct TagButton: View{
    @ObservedObject var tag: Tag
    @ObservedObject var tags: TagGroup
    var body: some View{
        Button(action: {
            //選択済み -> 除外
            if tag.isSelected{
                tags.tags.removeAll(where : {
                    $0.tagName == tag.tagName
                })
            }
            //新しく選択
            else{
                tags.tags.append(tag)
            }
            tag.isSelected.toggle()
        }){
            Text(tag.tagName)
                .background(Color.green)
                .cornerRadius(20)
                .scaleEffect(tag.isSelected ? 1.2 : 1)
        }
    }
}
