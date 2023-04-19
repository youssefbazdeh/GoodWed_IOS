//
//  addChecklist.swift
//  goodwed
//
//  Created by omarKaabi on 13/4/2023.
//

import SwiftUI
import Photos

struct addChecklist: View {
    @StateObject var checklistViewModel=ChecklistViewModel()

    @State private var nom: String = ""
    @State private var type: String = ""
    @State private var note: String = ""
    @State private var deadline: Date = Date()
    @State private var selectedOption = ""
    let options = ["all status","Completed","In Progress"]
    @State private var showImagePicker = false
    //@State private var image: Image? = Image(systemName: "logo")
    @State private var image: UIImage?
    @State private var showActionSheet = false
    @State private var showCK = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack {
            /*image?.resizable().scaledToFill().frame(width: 150,height: 150).clipShape(Circle()).foregroundColor(.gray)*/
            /*Button(action: {
                print("iiiiiiiisssssss")
                self.showActionSheet = true

            }) {
            // handle pick photo action here
                Text("Pick photo")
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image, sourceType: self.sourceType)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select photo"), buttons: [
                    .default(Text("Camera")) {
                        self.sourceType = .camera
                        self.showImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        self.sourceType = .photoLibrary
                        self.showImagePicker = true
                    },
                    .cancel()
                ])
            }
            .padding(.top, 10)*/
            VStack{
                if let selectedImage = image {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding()
                } else {
                    Button(action: {
                        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                            DispatchQueue.main.async {
                                switch status {
                                case .authorized:
                                    self.showImagePicker = true
                                    break
                                case .denied, .restricted:
                                    // Handle denied or restricted permission
                                    break
                                case .notDetermined:
                                    // Handle not determined permission
                                    break
                                default:
                                    break
                                }
                            }
                        }
                        // Code to be executed when the button is tapped
                        print("Button tapped")
                    }) {
                        Image(systemName: "photo").resizable().frame(width: 30,height: 30)// Set the icon using an SF Symbol
                            .foregroundColor(.gray)
                        Text("Photo").foregroundColor(Color.black)// Set the icon's color
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: self.$image, sourceType: self.sourceType)
                    }
                }
            }
                
            
            VStack(alignment: .leading) {
                TextField("Name", text: $nom)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Type", text: $type)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Note", text: $note)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                HStack{
                    DatePicker(
                        "",
                    selection: $deadline,
                    displayedComponents: [.date]
                    )
                    .accentColor(.white)
                    .labelsHidden()
                    Text(dateFormatter.string(from: deadline))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.gray)
                }
                .padding(.horizontal,40)
                
                Picker("Status", selection: $selectedOption){
                    ForEach(options, id: \.self){option in
                        Text(option)
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                .padding(.horizontal, 120)
                
                VStack{
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let dateString = dateFormatter.string(from: deadline)
                        print(dateString)
                    
                        checklistViewModel.AddChecklist(nom:nom,type: type,note:note, image: image!,date: dateString,status: selectedOption) { result in
                            switch result {
                            case .success(let response):
                                // Handle successful sign up
                                print(response)
                                // Dismiss the sign in view after successful sign up
                                
                                // Redirect to login page
                                
                            case .failure(let error):
                                // Handle error
                                print(error.localizedDescription)
                            }
                        }
                    }) {
                        Text("Add Checklist")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 290, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 177)
                                    .fill(Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686321, alpha: 1)))
                            )
                    }
                }
                .padding(.horizontal,45)
            }
            .padding(.top, 20)
    
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    struct addChecklist_Previews: PreviewProvider {
        static var previews: some View {
            addChecklist()
        }
    }
}
/*struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: image)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}*/
	
