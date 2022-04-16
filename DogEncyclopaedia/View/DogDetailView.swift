//
//  DogDetailView.swift
//  DogEncyclopaedia
//
//  Created by Long Hei Au on 6/4/2022.
//

import SwiftUI

struct DogDetailView: View {
    
    var dogImage : String
    var dogVariety : String
    var dogVarietyDetail : String
    
    var body: some View {
        VStack (alignment: .leading) {
                Image(dogImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                Text(dogVariety)
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                    .padding(.bottom, 20)
                Text(dogVarietyDetail)
                Spacer()
            }
            .padding()
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dogImage: "blankImage", dogVariety: "Testing Data", dogVarietyDetail: "Testing Data")
    }
}
