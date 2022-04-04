//
//  ComicResultList.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import SwiftUI

struct ComicResultList: View {
    
    var searchTerms: String
    @State var listOfComics = comics
    
    var body: some View {
        
        if(listOfComics.count <= 0){
            Label("No comics found, try searching for a new hero", systemImage: "info.circle")
        }
        
        Spacer()
        List(listOfComics) { comic in
            NavigationLink {
                ComicResultDetail(comic: comic)
            } label: {
                ComicResultRow(comic: comic)
            }
        }
        .onAppear {
            listOfComics.removeAll()
            let apiClient = APIClient()
            apiClient.send(SearchComics(titleStartsWith: searchTerms, limit: 20)) { response in
                print("\nGetComics finished:")
                
                do {
                    let dataContainer = try response.get()
                    
                    for comic in dataContainer.results {
                        listOfComics.append(comic)
                    }
                } catch {
                    print(error)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Comics with your hero")
    }
}

struct ComicResultList_Previews: PreviewProvider {
    static var previews: some View {
        ComicResultList(searchTerms: "hulk")
    }
}
