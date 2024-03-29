//
//  LoadingView.swift
//  TriOlympic
//
//  Created by Nigel Karan on 19.11.21.
//

import SwiftUI

struct LoadingView: View {
    var loadingText: String
    var body: some View {
        ZStack {
            Color("MainText")
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(20)
                .opacity(0.8)
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.mainButton))
                    .scaleEffect(3)
                
                Text(loadingText)
                    .foregroundColor(Color.mainButton)
                    .font(.title3)
                    .padding(.top,30)
                
            }
            
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingText: "")
    }
}
