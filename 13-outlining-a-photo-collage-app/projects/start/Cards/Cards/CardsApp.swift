//
//  CardsApp.swift
//  Cards
//
//  Created by 陶涛 on 2022/2/14.
//

import SwiftUI

@main
struct CardsApp: App {
    @StateObject var viewState = ViewState()

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environmentObject(viewState)
        }
    }
}
