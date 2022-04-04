//
//  ARViewRepresentable.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import SwiftUI
import ARKit

struct ARViewRepresentable: UIViewRepresentable {
    let arDelegate:ARDelegate
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARSCNView(frame: .zero)
        arDelegate.setARView(arView)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ARViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        ARViewRepresentable(arDelegate: ARDelegate(savedURL: comics[0].thumbnail!.url))
    }
}
