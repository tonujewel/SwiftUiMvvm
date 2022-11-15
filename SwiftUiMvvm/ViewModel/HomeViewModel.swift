//
//  HomeViewModel.swift
//  SwiftUiMvvm
//
//  Created by Singularity - Jewel Rana on 15/11/22.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject{
    
    enum ViewState{
        case START
        case LOADING
        case SUCCESS(users: [UserDm])
        case FAILURE(error: String)
    }
    
    
    @Published var currentState: ViewState = .START
    private var cancelables = Set<AnyCancellable>()
    
    init(){
        getUser()
    }
    
    func getUser(){
        self.currentState = .LOADING
        
        ApiService.shared.getUsers().sink{ completion in
            switch completion {
            case .finished:
                print("success")
            case .failure(let error):
                self.currentState = .FAILURE(error: error.localizedDescription)
            }
            
        } receiveValue: { user in
            self.currentState = .SUCCESS(users: user)
        }.store(in: &cancelables)
    }
    
}
