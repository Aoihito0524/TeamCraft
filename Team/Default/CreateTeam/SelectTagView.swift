//
//  SelectTagView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct SelectTagView: View{
    @Binding var selectedTags: [Tag]
    var body: some View{
        Rectangle()
        ForEach(TagGroup.allTags){tag in
            TagButton(tag: tag, selectedTags: $selectedTags)
        }
    }
}

struct TagButton: View{
    @State var tag: Tag
    @Binding var selectedTags: [Tag]
    var body: some View{
        Button(action: {
            //選択済み -> 除外
            if tag.isSelected{
                selectedTags.removeAll(where : {
                    $0.tagName == tag.tagName
                })
            }
            //新しく選択
            else{
                selectedTags.append(tag)
            }
            tag.isSelected.toggle()
        }){
            TagLabel(tag: tag)
                .scaleEffect(tag.isSelected ? 1.2 : 1)
        }
    }
}

