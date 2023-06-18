//
//  TeamCraftApp.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

let DEVICE_HEIGHT = UIScreen.main.bounds.height
let DEVICE_WIDTH = UIScreen.main.bounds.width
let BACKGROUND_COLOR = LinearGradient(colors: [Color(red: 0.890, green: 0.533, blue: 0, opacity: 0.71), Color(red: 1, green: 0.898, blue: 0, opacity: 0.35)], startPoint: .top, endPoint: .bottom)
let VERTICAL_SCROLLPANEL_WIDTH = DEVICE_WIDTH*0.869

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TeamCraftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
