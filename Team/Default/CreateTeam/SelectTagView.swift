//
//  SelectTagView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct SelectTagView: View{
    @Binding var selectedTagsGroup: TagGroup
    var body: some View{
        ForEach(TagGroup.allTags){tag in
            TagButton(tag: tag, selectedTagsGroup: $selectedTagsGroup)
        }
    }
}

struct TagButton: View{
    @State var tag: Tag
    @Binding var selectedTagsGroup: TagGroup
    var tagIsSelected: Bool{
        get{
            return selectedTagsGroup.Contains(tag: tag)
        }
    }
    var body: some View{
        Button(action: {
            //選択済み -> 除外
            if tagIsSelected{
                selectedTagsGroup.tags.removeAll(where : {
                    $0.tagName == tag.tagName
                })
            }
            //新しく選択
            else{
                selectedTagsGroup.tags.append(tag)
            }
        }){
            TagLabel(tag: tag)
                .scaleEffect(tagIsSelected ? 1.2 : 1)
        }
    }
}

