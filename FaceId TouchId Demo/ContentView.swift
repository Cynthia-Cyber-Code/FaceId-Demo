//
//  ContentView.swift
//  FaceId TouchId Demo
//
//  Created by Cynthia on 20/11/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var text = "locked"
    @State private var content = "open"
    @State private var image = "closed_box"
    @State private var color = Color.red
    @State private var colorButton = Color.green
    var body: some View {
        VStack (alignment: .center) {
            Text(" Application\n \(text)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Image(image)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding()
                    .overlay(Circle().stroke(color, lineWidth: 4))
            Button {
                if isUnlocked {
                    text = "Unlocked"
                    color = .green
                    content = "lock"
                    colorButton = .red
                    image = "opened_box"
                } else {
                    text = "Locked"
                    color = .red
                    content = "open"
                    colorButton = .green
                    image = "closed_box"
                }
            } label: {
                Text(content)
                    .padding()
                    .foregroundColor(.white)
                    .background(colorButton)
                    .cornerRadius(10)
            }.onAppear(perform: authenticate)
        }
       
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication completed
                if success {
                    isUnlocked = true
                } else {                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    ContentView()
}
