//
//  BikeBackground.swift
//  TriOlympic
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct BikeBackground: View {
    var body: some View {
        ZStack {
            Image("Photo_bike")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            Color((.systemBackground))
                .ignoresSafeArea()
                .opacity(0.8)
        }
    }
}

struct BikeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BikeBackground()
    }
}
