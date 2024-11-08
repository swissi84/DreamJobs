//
//  Settings.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 16.09.24.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("username") var username = ""
    @AppStorage("email") var email = ""
    @AppStorage("birthday") var birthday = ""
    @AppStorage("location") var location = ""
    @AppStorage("language") var language = ""
    @AppStorage("notification") var notification = false
    @AppStorage("darkmode") var darkmode = false
    @AppStorage("fontsize") private var textSize : Double = 16.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextField("Birthday", text: $birthday)
                    TextField("Location", text: $location)
                    TextField("Language", text: $language)
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Notification", isOn: $notification)
                    Toggle("Dark Mode", isOn: $darkmode)
                    
                    VStack(alignment: .leading) {
                        Text("Text Size")
                        Slider(value: $textSize, in: 16.0...24.0, step: 1)
                            .padding()
                        Text("Current Size: \(Int(textSize)) pt")
                                               .font(.system(size: textSize))
                                               .padding(.bottom, 20)
                        
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingView()
}


