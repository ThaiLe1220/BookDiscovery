/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 12/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import Foundation

import SwiftUI

// ImagePicker conforms to UIViewControllerRepresentable,
// allowing you to use a UIKit-based UIImagePickerController in a SwiftUI view.
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?     // Binding to the UIImage optional that will hold the selected image


    func makeUIViewController(context: Context) -> UIImagePickerController {     // Create and configure the UIImagePickerController instance

        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}    // Function needed for UIViewControllerRepresentable protocol, but not used here, so left empty

    func makeCoordinator() -> Coordinator {// Create a Coordinator instance to act as the UIImagePickerController delegate

        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {     // The Coordinator class is responsible for delegating the UIImagePickerController actions

        var parent: ImagePicker         // Reference to the parent ImagePicker view


        init(_ parent: ImagePicker) {         // Initializer

            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {         // Did finish picking media

            if let selectedImage = info[.originalImage] as? UIImage {             // Extract the selected image and set it in the parent view

                parent.selectedImage = selectedImage
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {         // Handle image picker cancellation

        }
    }
}
