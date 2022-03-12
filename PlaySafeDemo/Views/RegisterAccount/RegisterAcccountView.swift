import SwiftUI

struct RegisterAcccountView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var countryCode: CountryCode? = .none
    @StateObject private var viewModel = RegisterAccountViewModel()
    
    var body: some View {
        VStack {
            Text("Welcome to PlaySafe Streaming Demo App")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.vertical, 30)

            Form {
                TextField("Email", text: $email)

                TextField("Username", text: $email)

                SecureField("New Password", text: $newPassword)

                SecureField("Confirm Password", text: $confirmPassword)

                Picker(selection: $countryCode, label: Text("Select your country")) {
                    Text("Malaysia").tag(CountryCode.MY)
                    Text("South Korea").tag(CountryCode.KR)
                    Text("Japan").tag(CountryCode.JP)
                    Text("Singapore").tag(CountryCode.SG)
                    Text("Thailand").tag(CountryCode.TH)
                    Text("Australia").tag(CountryCode.AU)
                    Text("Hong Kong").tag(CountryCode.HK)
                }

                Button("Confirm") {

                }

                Button("Back") {

                }
            }

            Spacer()
        }
        .navigationTitle("Register Account")
    }
}

struct RegisterAcccountView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAcccountView()
    }
}
