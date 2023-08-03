import SwiftUI

struct FoodScannerView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showSheet = false
    var body: some View {
        VStack {
            Image(systemName: "camera")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            scanButton
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .confirmationDialog("", isPresented: $showSheet, titleVisibility: .hidden) {
            Button("Camera is not available") {
                print("retry")
            }
        }
    }
    
    var scanButton: some View {
        Button {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                showImagePicker = true
            } else {
                showSheet = true
            }
        } label: {
            Text("Scan a food")
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(.blue)
        .cornerRadius(10)
    }
}
