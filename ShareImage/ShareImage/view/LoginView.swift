//
//  LoginView.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var name: String = ""
    @State var selection: Int? = nil
    @State var userIdValue : Int = 0
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .center, spacing: 30) {
                    TextField("Enter device name", text: $name).padding().border(Color.gray, width: 2)
                    Text("Hello, \(name)!")
                    
                    if name.count > 4{
                        NavigationLink(destination: ShareView(userIdValue: self.userIdValue), tag: 1, selection: $selection) {
                            
                            
                            Button(action:{
                                // action
                                self.viewModel.login(username: self.name, completion :{ userId, error in
                                    if let userId = userId {
                                        print(userId)
                                        self.selection = 1
                                        self.userIdValue = userId
                                        
                                    }
                                })
                            }){
                                Group{
                                    Text("Login")
                                        .fontWeight(.semibold)
                                        .font(.title)
                                } .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                            }
                        }.navigationBarTitle("Login").environment(\.horizontalSizeClass, .compact)
                    }
                }.padding()
                
            }
        }.phoneOnlyStackNavigationView()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
