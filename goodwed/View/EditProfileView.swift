import SwiftUI

struct EditProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var fullname: String = ""
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showAlert = false // new state variable for showing/hiding the alert
    
    init(viewModel: ProfileViewModel) {
        _username = State(initialValue: viewModel.user?.username ?? "")
        _email = State(initialValue: viewModel.user?.email ?? "")
        _fullname = State(initialValue: viewModel.user?.fullname ?? "")
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack {
                    Form {
                        Section(header: Text("Personal Information")) {
                            TextField("Username", text: $username)
                            TextField("Full name", text: $fullname)
                            TextField("Email", text: $email)
                        }

                        Section {
                            Button("Save Changes") {
                                let request = UpdateUserRequest(username: username, fullname: fullname, email: email)
                                viewModel.updateUser(request: request) {
                                   
                                    print("User updated successfully!")
                                    showAlert = true
                                }
                            }
                        }
                    }
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("User updated successfully!"), dismissButton: .default(Text("OK")))
            }
        }
    }


    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


