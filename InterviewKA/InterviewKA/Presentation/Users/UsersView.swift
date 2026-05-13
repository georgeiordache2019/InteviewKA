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
                ScrollView {
                    ForEach(viewModel.filteredUsers, id: \.email) { user in
                        VStack {
                            HStack {
                                NavigationLink {
                                    UserDetailView(user: user)
                                } label: {
                                    Text(user.name.first)
                                        .padding()
                                }
                                Spacer()
                                
                                Button(role: .destructive) {
                                    viewModel.deleteUser(user)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }.padding(.horizontal)
                        }
                    }
                }
                
                Button("Show More") {
                    Task {
                        await viewModel.getUsers()
                    }
                }
            }.padding(.vertical)
        }
        .searchable(text: $viewModel.searchText,
                    prompt: "Search by name, surname or email")
        .task {
            await viewModel.getUsers()
        }
        .navigationTitle("Users")
    }
}

