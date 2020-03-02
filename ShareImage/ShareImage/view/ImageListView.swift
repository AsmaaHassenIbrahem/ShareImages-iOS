//
//  ImageListView.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImage

struct ImageListView: View {
    
    @State private var viewModel = ViewModel()
    @State var userIdValue : Int = 0
    @State private var  images = [ImageRow]()
    
    var body: some View {
        
        List(images,id: \.picture) { item  in
            if self.images.count > 0 {
                HStack(alignment: .center, spacing: 20) {
                    Group(){
                        WebImage(url: URL(string: item.picture)).resizable()
                            .placeholder(Image(systemName: "photo"))
                            .frame(width: 100, height: 100, alignment: .leading)
                        Text(item.postOwner)
                    }
                }
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        viewModel.getImagesVal(userId: userIdValue, completion:{(response, Error) in
            self.images = response.result
        })
    }
}


struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: 0) var code: Int
        
        
        var body: some View {
            ImageListView(userIdValue: code)
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
