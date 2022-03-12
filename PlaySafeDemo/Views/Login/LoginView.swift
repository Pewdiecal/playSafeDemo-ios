import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isCredentialValid = false
    @StateObject private var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                    Text("Welcome to PlaySafe Streaming Demo App")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.vertical, 30)

                    Form {
                        TextField("Username", text: $username)
                        SecureField("Password", text: $password)
                        Button("Login") {
                            loginViewModel.login(username: username, password: password)
                            isCredentialValid = loginViewModel.networkRequestService != nil
                        }

                        Button("Register Account") {

                        }
                    }

                    Spacer()
                    NavigationLink("", destination: HomeView(), isActive: $isCredentialValid)
            }
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
