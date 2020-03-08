//
//  PostView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/6/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct PostView: View {
    
    var passed_postingUser: String
    var passed_description: String
    var passed_numberOfLikes: Int
    var passed_image: Image
    
    
    var body: some View {
        VStack {
            passed_image
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95).opacity(0.6))
            VStack {
                HStack {
                    Image(systemName: "heart")
                    Image(systemName: "envelope")
                    Spacer()
                    Image(systemName: "bookmark")
                }
                
                HStack {
                    Text("\(passed_postingUser)")
                    Text("\(passed_numberOfLikes) likes")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .font(.system(size: 14, weight: .bold))
                
                HStack {
                    Text("\(passed_description)")
                    Spacer()
                }
                .font(.system(size: 14, weight: .regular))
            }.padding()
                //.background(Color.orange)
        }
        //.background(Color.yellow)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(passed_postingUser: "kljla;sdlf fsalkd", passed_description: "This is a description for this post. aldf alsdf lkj iasj falksdf asdf asldf asdf iaoisdfjafoiiuhew aldfu.", passed_numberOfLikes: 1000, passed_image: Image(systemName: "heart.fill"))
    }
}
