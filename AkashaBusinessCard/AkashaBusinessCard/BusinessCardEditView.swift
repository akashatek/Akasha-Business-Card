//
//  BusinessCardEditView.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 09/02/2026.
//

import SwiftUI
import PhotosUI
#if os(macOS)
import UniformTypeIdentifiers
#endif

struct BusinessCardEditView: View {
    @Binding var businessCard: BusinessCard
    @State private var showingFileImporter = false
    #if os(iOS)
    @State private var selectedPhotoItem: PhotosPickerItem?
    #endif
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Section
                SectionHeader(title: "Profile")
                
                VStack(spacing: 16) {
                    TextField("First Name", text: $businessCard.firstname)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Last Name", text: $businessCard.lastname)
                        .textFieldStyle(.roundedBorder)
                    
                    imagePickerRow
                }
                
                Spacer(minLength: 40)
            }
            .padding()
        }
        .fileImporter(
            isPresented: $showingFileImporter,
            allowedContentTypes: [.image],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    importImage(from: url)
                }
            case .failure(let error):
                print("File import error: \(error)")
            }
        }
        #if os(iOS)
        .onChange(of: selectedPhotoItem) { _, newItem in
            if let item = newItem {
                loadImage(from: item)
            }
        }
        #endif
    }
    
    // MARK: - Image Picker Row
    @ViewBuilder
    private var imagePickerRow: some View {
        HStack {
            Text("Profile Photo")
                .frame(width: 120, alignment: .leading)
            
            #if os(macOS)
            Button {
                showingFileImporter = true
            } label: {
                imagePreview
            }
            .buttonStyle(.bordered)
            #else
            if #available(iOS 17.0, *) {
                Button {
                    showingFileImporter = true
                } label: {
                    imagePreview
                }
                .buttonStyle(.bordered)
            } else {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    imagePreview
                }
                .buttonStyle(.bordered)
            }
            #endif
            
            if businessCard.profileImage != nil && !businessCard.profileImage!.isEmpty {
                Button {
                    businessCard.profileImage = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.borderless)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var imagePreview: some View {
        if let imageName = businessCard.profileImage, !imageName.isEmpty {
            Image(imageName)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .frame(width: 80, height: 80)
        }
    }
    
    // MARK: - Image Import
    private func importImage(from url: URL) {
        let fileName = url.lastPathComponent
        let destURL = getSupportDirectory().appendingPathComponent(fileName)
        
        do {
            // Start accessing security-scoped resource
            let accessing = url.startAccessingSecurityScopedResource()
            defer {
                if accessing {
                    url.stopAccessingSecurityScopedResource()
                }
            }
            
            // Remove existing file if present
            if FileManager.default.fileExists(atPath: destURL.path) {
                try FileManager.default.removeItem(at: destURL)
            }
            
            // Copy file to support directory
            try FileManager.default.copyItem(at: url, to: destURL)
            
            // Set profileImage to the filename
            businessCard.profileImage = fileName
        } catch {
            print("Error importing image: \(error)")
        }
    }
    
    // MARK: - Image Import (iOS 16 and below)
    #if os(iOS)
    private func loadImage(from item: PhotosPickerItem) {
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                let fileName = UUID().uuidString + ".jpg"
                let destURL = getSupportDirectory().appendingPathComponent(fileName)
                if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                    try? jpegData.write(to: destURL)
                    await MainActor.run {
                        businessCard.profileImage = fileName
                        selectedPhotoItem = nil
                    }
                }
            }
        }
    }
    #endif
    
    private func getSupportDirectory() -> URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("AkashaBusinessCard")
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.accentColor)
            .padding(.bottom, 4)
    }
}

#Preview {
    BusinessCardEditView(businessCard: .constant(.defaultCard))
}
