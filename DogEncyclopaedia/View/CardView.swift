//
//  CardView.swift
//  DogEncyclopaedia
//
//  Created by Long Hei Au on 4/4/2022.
//

import SwiftUI

struct CardView: View {
    
    var dogImage : String
    var dogVariety : String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(dogImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
            Text(dogVariety)
                .font(.title2)
                .foregroundColor(.primary)
                .fontWeight(.medium)
                .padding(.bottom, 10)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(dogImage: "blankImage", dogVariety: "Dog Variety")
    }
}
