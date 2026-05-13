//
//  UsersView.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel: UsersViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        Text(user.name.first)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getUsers()
            }
        }
        .navigationTitle("Users")
    }
}

