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
        VStack {
            ForEach(viewModel.users) { user in
                Text("\(user.name.first)")
            }
        }
        .onAppear {
            Task {
                await viewModel.getUsers()
            }
        }
    }
}
        
