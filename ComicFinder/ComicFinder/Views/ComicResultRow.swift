//
//  ComicResultRow.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import SwiftUI

struct ComicResultRow: View {
    
    var comic: Comic
    
    var body: some View {
        HStack {
            AsyncImage(url: comic.thumbnail?.url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 50, maxHeight: 50)
            
            Text(comic.title!)
            
            Spacer()
        }
    }
}

struct ComicResultRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ComicResultRow(comic: comics[0])
            ComicResultRow(comic: comics[1])
            ComicResultRow(comic: comics[2])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
