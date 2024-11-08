import SwiftUI
import SwiftData

@main
struct DreamJob: App {
    @AppStorage("darkmode") private var darkmode = false
    @AppStorage("fontsize") private var textSize : Double = 16.0
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn = false
    
    
    
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                TabView {
                    ContentView()
                        .preferredColorScheme(darkmode ? .dark : .light)
                    
                        .tabItem {
                            Label("Jobs", systemImage: "house")
                        }
                    
                    FavoriteView()
                    
                        .tabItem {
                            Label("Favorite Jobs", systemImage: "star.fill")
                        }
                    
                    
                    JobAddView()
                    
                        .tabItem {
                            Label("Add Jobs", systemImage: "briefcase")
                        }
                    
                    SettingView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .modelContainer(for: [
                    Job.self,
                    Skill.self
                ])
          
            } else {
                LoginView()
            }
        }
    }
    
}

