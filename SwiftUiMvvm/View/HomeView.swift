//
//  HomeView.swift
//  SwiftUiMvvm
//
//  Created by Singularity - Jewel Rana on 15/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            if case .LOADING = viewModel.currentState{
                loaderView()
            } else if case .SUCCESS(let user) = viewModel.currentState{
                List(user){ user in
                    userCell(user: user)
                        .frame(width: geometry.size.width, height:80)
                }
            } else if case .FAILURE(let error) = viewModel.currentState {
                VStack(alignment: .center) {
                    Spacer()
                    Text(error)
                        .font(.headline.bold())
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

func userCell(user: UserDm) -> some View {
    HStack(spacing: 40) {
        AsyncImage(url: URL(string: user.avatar_url ?? "Unknown user")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 60, height: 60, alignment: .center)
        .clipShape(Circle())

        VStack(alignment: .leading, spacing: 0)  {
  
            Text(user.login ?? "")
                .font(.headline)
            
            Text(user.node_id ?? "")
                .font(.system(size: 14))
        }
        
  
        Spacer()
    }
    .padding(.leading,35)
}

func loaderView() -> some View {
    ZStack {
        Color.black.opacity(0.05)
            .ignoresSafeArea()
        ProgressView()
            .scaleEffect(1, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
