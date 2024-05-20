//
//  ProfileViewViewModel.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import FirebaseStorage

class ProfileViewViewModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var imageURL: URL? = nil
    @Published var image: UIImage? {
        didSet {
            saveImageToFirebaseStorage(image)
        }
    }
    
    var loader = APIImage()
    
    func fetchUser() { //  Fetches the current user's data from Firestore based on their userID
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
                
                if let profileImageUrlString = data["profileImageUrl"] as? String,
                   let url = URL(string: profileImageUrlString) {
                    self?.imageURL = url
                }
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print(error)
        }
    }
    
    
    
    // Fetch a random image from an API
    func fetchImageWithCompletion() {
        loader.getImageWithCompletion { [weak self] image, error in
            self?.image = image
            self?.saveImageToFirebaseStorage(image)
        }
    }
    
    // upload an image to Firebase Storage
    func saveImageToFirebaseStorage(_ image: UIImage?) {
        guard let userId = Auth.auth().currentUser?.uid,
              let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            guard let self = self, error == nil else {
                print("Error saving image to Firebase Storage: \(error?.localizedDescription ?? "")")
                return
            }
            // download URL of the image that was uploaded to Firebase Storage
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "")")
                    return
                }
                // update the user's profile image URL
                self.updateUserProfileImageURL(downloadURL, for: userId)
            }
        }
    }
    
    // Updates the user's Firestore document with the new image URL and updates the imageURL property.
    func updateUserProfileImageURL(_ url: URL, for userId: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["profileImageUrl": url.absoluteString]) { error in
            if let error = error {
                print("Error updating user profile image URL: \(error.localizedDescription)")
                return
            }
            
            // Update the imageURL property to reflect the new URL
            DispatchQueue.main.async {
                self.imageURL = url
            }
        }
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "ProfileViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }

        let userId = user.uid // Directly assign since `uid` is non-optional

        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
        let userRef = db.collection("users").document(userId)

        do {
            // Delete user data from Firestore
            try await userRef.delete()

            // Delete profile image from Storage
            // if there is no uploaded photo, it will show an error as its nothing to delete from Storage
           try await storageRef.delete()

            // Delete the user from Firebase Auth
            try await user.delete()
        } catch {
            throw error
        }
    }
}
