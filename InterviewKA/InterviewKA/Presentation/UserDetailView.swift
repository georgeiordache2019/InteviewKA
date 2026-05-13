//
//  UserDetailView.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack {
            Text(user.gender)
            Text(user.name.fullName)
                .font(.largeTitle)
            Text(user.email)
            if let userImage =  user.picture.urlImage {
                AsyncImage(url: userImage)
            }
        }
        .navigationTitle("User Details")
    }
}
