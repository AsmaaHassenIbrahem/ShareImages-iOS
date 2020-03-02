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

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct ShareView: View {
    @State private var isPublic = true
    
    @State private var toggleState = "public"
    @State private var showingImagePicker = false
    @State private var image : Image? = nil
    @State private var selection: Int? = nil
    @State private var showIndecator = false

    @State private var viewModel = ViewModel()
    
    @State var userIdValue : Int = 0
    
    var body: some View {
        LoadingView(isShowing: .constant(showIndecator)) {
        ScrollView {
            VStack(alignment: .center, spacing: 20){
                NavigationLink(destination: ImageListView(userIdValue : self.userIdValue), tag: 1, selection: self.$selection) {
                    Button("Shared Images"){
                        
                        self.selection = 1
                    }.padding().border(Color.black, width: 3)
                }.navigationBarTitle("Share")
                
                Button("click here and choose your image "){
                    self.showingImagePicker.toggle()}
                
                Toggle(isOn : self.$isPublic){
                    Text("image State")
                }.padding()
                
                if (self.isPublic) {
                    Text("public")
                } else {
                    Text("private")
                }
                if self.image == nil {
                    
                    Image(systemName: "person")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                    
                }else {
                    self.image?.resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                    
                    Button(action:{
                        self.showIndecator = true

                        self.viewModel.upload(image: ImagePicker.shareUIImage, userId: self.userIdValue, isPublic: self.isPublic, completion:{ isSuccess in
                            
                            if isSuccess {
                                self.showIndecator = false
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
                
            }.sheet(isPresented: self.$showingImagePicker,
                    content: {ImagePicker.share.view})
                .onReceive(ImagePicker.share.$image)
                {image in self.image = image }
        }
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
