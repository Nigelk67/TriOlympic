//
//  TriOlympicApp.swift
//  TriOlympic
//
//  Created by Nigel Karan on 24.12.21.
//

import SwiftUI
import Firebase

@main
struct TriOlympicApp: App {
    let persistenceController = PersistenceController.shared
    //For background identfication:
    @StateObject var sessionVm = SessionViewModel()
    @Environment(\.scenePhase) var scene

    init() {
        FirebaseApp.configure()
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.mainButton)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UITabBar.appearance().backgroundColor = UIColor(Color.accentButton)
        UITabBar.appearance().barTintColor = UIColor(Color.accentButton)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray.opacity(0.6))
    }
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(loginViewModel)
                .environmentObject(sessionVm)
        }
        .onChange(of: scene) { newScene in
            if newScene == .background {
                sessionVm.timeAtBackground = Date()
            }
            if newScene == .active {
                let diffInSecs = Date().timeIntervalSince(sessionVm.timeAtBackground)
                let currentTime = sessionVm.secs + Double(diffInSecs)
                if currentTime >= 0 {
                    withAnimation(.default) {
                        sessionVm.secs = currentTime
                        sessionVm.updateDisplay()
                    }
                }
            }
        }
    }
}
