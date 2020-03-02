//
//  ShareView.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import SwiftUI

struct BlueToggle : UIViewRepresentable {
    func makeUIView(context: Context) -> UISwitch {
        UISwitch()
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.onTintColor = .blue
    }
}

struct ShareView: View {
    @State private var isPublic = true
    
    @State private var toggleState = "public"
    @State private var showingImagePicker = false
    @State private var image : Image? = nil
    @State private var selection: Int? = nil
    
    @State private var viewModel = ViewModel()
    
    @State var userIdValue : Int = 0
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .center, spacing: 20){
                NavigationLink(destination: ImageListView(userIdValue : self.userIdValue), tag: 1, selection: $selection) {
                    Button("Shared Images"){
                        
                        self.selection = 1
                    }.padding().border(Color.black, width: 3)
                }.navigationBarTitle("Share")
                
                Button("click here and choose your image "){
                    self.showingImagePicker.toggle()}
                
                Toggle(isOn : $isPublic){
                    Text("image State")
                }.padding()
                
                if (isPublic) {
                    Text("public")
                } else {
                    Text("private")
                }
                if image == nil {
                    
                    Image(systemName: "person")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                    
                }else {
                    image?.resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                    
                    Button(action:{
                        self.viewModel.upload(image: ImagePicker.shareUIImage, userId: self.userIdValue, isPublic: self.isPublic, completion:{ isSuccess in
                            
                            if isSuccess {
                            }
                        })
                        
                    }){
                        Group{
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title)
                                Text("Share")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }
                        } .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                        
                    }.padding()
                }
                
            }.sheet(isPresented: $showingImagePicker,
                    content: {ImagePicker.share.view})
                .onReceive(ImagePicker.share.$image)
                {image in self.image = image }
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: 0) var code: Int
        
        var body: some View {
            ShareView(userIdValue: code)
        }
    }
}
