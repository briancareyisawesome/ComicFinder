//
//  ComicResultDetail.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import SwiftUI

struct ComicResultDetail: View {
    
    var comic: Comic
    
    var body: some View {
        ScrollView {
            AsyncImage(url: comic.thumbnail?.url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 500, maxHeight: 500)
            
            VStack(alignment: .leading) {
                
                Text(comic.title ?? "Comic Title Missing for this issue")
                
                    .font(.title)
                HStack {
                    Text(comic.format ?? "Comic Format Missing for this issue")
                }
                
                .font(.subheadline)
                .foregroundColor(.secondary)
                Divider()
                NavigationLink {
                    ComicARView(comicURL: comic.thumbnail!.url)
                } label: {
                    Text("Make comic appear in AR!")
                        .font(.title)
                }
                Divider()
                Spacer()
                Text("About This Comic")
                    .font(.title2)
                Text(comic.description ?? "Comic Description Missing for this issue")
            }
            .padding()
            Spacer()
            Text("Data provided by Marvel. © 2022 Marvel")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComicResultDetail_Previews: PreviewProvider {
    static var previews: some View {
        ComicResultDetail(comic: comics[0])
    }
}
