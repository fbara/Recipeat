//
//  HomeView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var HomePosts:[recipePost] = [
        recipePost(postingUser: "person", description: "This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse")),
        recipePost(postingUser: "adfasdfasfd", description: "This is a long description.This is a long description.This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse")),
        recipePost(postingUser: "afafdfd", description: "This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse")),
        recipePost(postingUser: "adfasfas", description: "This is a long description.This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse")),
        recipePost(postingUser: "afafadf", description: "This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse")),
        recipePost(postingUser: "sfadsfa", description: "This is a long description.This is a long description.This is a long description.This is a long description.", numberOfLikes: 112, image: Image(systemName: "timelapse"))
    ]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer().frame(width: 10)
                    ForEach(0 ..< 10) { item in
                        StoryCircleView()
                    }
                }.frame(height: 80)
            }.background(Color.clear)
            ScrollView {
                ForEach(HomePosts, id: \.id) { post in
                    PostView(passed_postingUser: post.postingUser, passed_description: post.description, passed_numberOfLikes: post.numberOfLikes, passed_image: post.image)
                }
            }.background(Color.clear)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
