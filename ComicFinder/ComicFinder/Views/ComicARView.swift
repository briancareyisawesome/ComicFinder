//
//  ComicARView.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import SwiftUI

struct ComicARView: View {
    
    public var comicImageURL: URL
    @ObservedObject var arDelegate: ARDelegate
    
    init(comicURL comicImageURL: URL) {
        self.comicImageURL = comicImageURL
        self.arDelegate = ARDelegate(savedURL: comicImageURL)
    }
    
    var body: some View {
        ZStack {
            ARViewRepresentable(arDelegate: arDelegate)
            VStack {
                Spacer()
                Text("Look around for a flat surface, like a desk or table. Then tap where you want this comic to appear!")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 80)
                    .background(Color.white)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ComicARView_Previews: PreviewProvider {
    static var previews: some View {
        ComicARView(comicURL: comics[0].thumbnail!.url)
    }
}
