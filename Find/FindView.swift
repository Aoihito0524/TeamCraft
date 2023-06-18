//
//  FindView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

struct FindView: View{
    @ObservedObject var findVM = FindViewModel()
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack{
                TopBar_FindView(searchText: $findVM.searchText, DoSearch: findVM.Search)
                ScrollView{
                    LazyVStack{
                        ForEach(findVM.searchResults){ teamInfo in
                            teamInformationUI(teamInfo: teamInfo, clickedTeamInfo: $findVM.clickedTeamInfo)
                        }
                        Divider()
                    }
                    .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
                    .background(Color.white)
                }
            }
            if let clickedTeamInfo = findVM.clickedTeamInfo{
                JoinPopupView(teamInfo: clickedTeamInfo)
            }
        }
    }
}

struct TopBar_FindView: View{
    @Binding var searchText: String
    let DoSearch: ()->()
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            VStack{
                Text("探す")
                    .font(.title)
                SearchField(searchText: $searchText, DoSearch: DoSearch)
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .background(Color.white.opacity(0.92))
    }
}

struct SearchField: View{
    @Binding var searchText: String
    let DoSearch: () -> ()
    var body: some View{
        HStack{
            Image(systemName: "magnifyingglass")
            TextField("検索", text: $searchText)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                    DoSearch()
                }
        }
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(10)
    }
}
class FindViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var searchResults = [TeamInformation]()
    @Published var clickedTeamInfo: TeamInformation?
    func Search(){
        let keywords = GetKeywords(input: searchText)
        if keywords == []{return;}
        SearchByKeywards(keywords: keywords)
    }
    private func GetKeywords(input: String) -> [String]{
        let pattern = "([^\\s　]+)"
        let regex = try? NSRegularExpression(pattern: pattern)
        let results = regex?.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) ?? []
        var keywordsArray = [String]()
        for result in results{
            if let range = Range(result.range, in: input) {
                keywordsArray.append(String(input[range]))
            }
        }
        print("キーワード: \(keywordsArray)")
        return keywordsArray
    }
    private func SearchByKeywards(keywords: [String]){
        var keywords_2character = [String]()
        for keyword in keywords {
            for num in 0..<keyword.count-1{
                let fromIdx = keyword.index(keyword.startIndex, offsetBy: num)
                let toIdx = keyword.index(keyword.startIndex, offsetBy: num+1)
                let str = String(keyword[fromIdx...toIdx])
                keywords_2character.append(str)
            }
        }
        searchResults = []
        let db = Firestore.firestore()
        var query = db.collection("teamInformation").whereField("keywords", arrayContainsAny: keywords_2character)
        query = query.limit(to: 100) //100件まで
        query.getDocuments {(snapshot, error) in
            if let documents = snapshot?.documents{
                print("\(documents.count)件ヒットしました")
                for document in documents {
                    self.searchResults.append(TeamInformation(document: document))
                }
            }
            else{
                print("documentsがnilです")
            }
        }
    }
}
