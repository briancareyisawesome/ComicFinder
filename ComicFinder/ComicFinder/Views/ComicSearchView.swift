//
//  ContentView.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/2/22.
//

import SwiftUI

struct ComicSearchView: View {
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5.0) {
                
                Image("marvelheader")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                
                Text("Search for comic books by entering your favorite hero")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack {
                    TextField("i.e. Hulk", text: $name)
                        .padding(.leading, 10.0)
                        .frame(width: 200.0, height: 40.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                }
                
                NavigationLink("Search") {
                    ComicResultList(searchTerms: name)
                }
                .padding(.all, 10.0)
                .border(Color.black, width: 3)
                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ComicSearchView()
    }
}
