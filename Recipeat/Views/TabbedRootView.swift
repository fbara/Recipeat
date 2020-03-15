//
//  ContentView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct TabbedRootView: View {
    @State private var selection = 0
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        
        ZStack {
            NavigationView {
                Text("")
            }.navigationBarTitle("\(env.currentUser.username)")
            .navigationBarHidden(true)
            
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                }
                .tag(0)
                SearchView()
                    
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                }
                .tag(1)
                MeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.circle")
                            Text("Me")
                        }
                }
                .tag(2)
            }
        }
    }
}
    
    struct TabbedRootView_Previews: PreviewProvider {
        static var previews: some View {
            TabbedRootView()
        }
}
