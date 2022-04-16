//
//  ContentView.swift
//  DogEncyclopaedia
//
//  Created by Long Hei Au on 2/4/2022.
//

import SwiftUI

import CoreML
import Vision
import CoreImage

struct HomeView: View {
    @ObservedObject var datas = ReadData()
    
    @State var changeImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    @State private var searchText = ""
    @State var showDogDetailView = false
    @State var showView = false
    @State var res: Int
    
    let model = DogEncyclopaediaClassifierModel()
        
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    NavigationLink(isActive: $showDogDetailView) {
                        ForEach (datas.dogs) { dog in
                            if searchText.lowercased() == dog.dog_name_en.lowercased() {
                                DogDetailView(dogImage: "\(dog.id)", dogVariety: "\(dog.dog_name_en)", dogVarietyDetail: "\(dog.description)")
                            }
                        }
                    } label: {
                        EmptyView()
                    }
                }
                VStack {
                    NavigationLink(isActive: $showView) {
                        ForEach (datas.dogs) { dog in
                            if res == dog.id {
                                DogDetailView(dogImage: "\(dog.id)", dogVariety: "\(dog.dog_name_en)", dogVarietyDetail: "\(dog.description)")
                            }
                        }
                    } label: {
                        EmptyView()
                    }
                }
                VStack {
                    List {
                        Image("HomeIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 80, alignment: .topLeading)
                        TextField("   Search Here", text: $searchText)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(7)
                            .shadow(color: .gray, radius: 4, x: 0, y: 0)
                            .padding(.bottom, 20)
                            .listRowSeparator(.hidden)
                            .onSubmit {
                                showDogDetailView = true
                            }
                        Text("Variety List")
                            .fontWeight(.bold)
                            .font(.title)
                        ForEach (datas.dogs) { dog in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: {
                                    DogDetailView(dogImage: "\(dog.id)", dogVariety: "\(dog.dog_name_en)", dogVarietyDetail: "\(dog.description)")
                                }, label: {
                                    EmptyView()
                                }).opacity(0)
                                CardView(dogImage: "\(dog.id)", dogVariety: "\(dog.dog_name_en)")
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        openCameraRoll = true
                        
                    }) {
                        Image(systemName: "camera")
                    }
                }
            }
        }
        .sheet(isPresented: $openCameraRoll) {
            ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            .onDisappear{
                if $imageSelected != nil {
                    classifyImage(image: imageSelected)
                }
            }
        }
    }
    
    private func classifyImage(image:UIImage) {
        let image = image
        let resizedImage = image.resizeImageTo(size: CGSize(width: 299, height: 299))
        let buffer = resizedImage!.convertToBuffer()
        let output = try! model.prediction(image: buffer!)
        let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
        let result = results[0].key
        for dog in datas.dogs where dog.dog_name_en.lowercased() == result.lowercased(){
            print(dog.id)
            print(dog.dog_name_en)
            res = dog.id
        }
        showView = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(res: 0)
    }
}


