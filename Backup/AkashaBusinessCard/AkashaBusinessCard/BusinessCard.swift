//
//  BusinessCard.swift
//  AkashaBusinessCard
//
//  Created by Alvin HEIB on 28/01/2026.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct BusinessCard {
    var id = UUID()
    var fullName: String = "Alvin Heib"
    var name: String = "Heib; Alvin;"
    var email: String = "heibalvin@akashatek.com"
    var mobile: String = "+971 58 889 1030"
    var photo: String = "alvin-heib"
    var organisation: String = "Akasha Tek"
    var title: String = "Global Partnership Advisor"
    var logo: String = "akasha-tek-logo-512x512"
    
    func imageBase64Encoding(name: String) -> String? {
        #if os(iOS)
        guard let uiImage = UIImage(named: name) else { return nil }
        guard let cgImage = uiImage.cgImage else { return nil }
        let originalSize = uiImage.size
        #else
        guard let nsImage = NSImage(named: name) else { return nil }
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return nil }
        let originalSize = nsImage.size
        #endif

        // Scale down to max 64x64 while maintaining aspect ratio
        let maxSize: CGFloat = 64
        let scale = min(maxSize / originalSize.width, maxSize / originalSize.height)
        let newSize = CGSize(width: originalSize.width * scale, height: originalSize.height * scale)

        // Resize using CoreGraphics
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: nil, width: Int(newSize.width), height: Int(newSize.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        context.draw(cgImage, in: CGRect(origin: .zero, size: newSize))
        guard let resizedCGImage = context.makeImage() else { return nil }

        // Convert to Data
        #if os(iOS)
        let resizedImage = UIImage(cgImage: resizedCGImage)
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }
        #else
        let resizedImage = NSImage(cgImage: resizedCGImage, size: newSize)
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }
        #endif

        // Convert to Base64
        return imageData.base64EncodedString()
    }
    
    func vCardGen() -> String {
        // Use "\r\n" for proper line breaks in the vCard format
        let vCardString = """
        BEGIN:VCARD
        VERSION:4.0
        FN:\(fullName)
        N:\(name)
        PHOTO;TYPE=JPEG;ENCODING=BASE64:\(imageBase64Encoding(name: photo) ?? "")
        ORG:\(organisation)
        TITLE:\(title)
        TEL;TYPE=work:\(mobile)
        EMAIL;TYPE=work:\(email)
        END:VCARD
        """
        return vCardString.replacingOccurrences(of: "\n", with: "\r\n")
    }
    
    func QRCodeGen(from string: String) -> Image {
        print("QRCodeGen: String length: \(string.count)")
        print("QRCodeGen: String preview: \(String(string.prefix(200)))...")

        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        guard let data = string.data(using: .utf8) else {
            print("QRCodeGen: Failed to convert string to data")
            return Image(systemName: "xmark.octagon")
        }
        filter.setValue(data, forKey: "inputMessage")

        // Use low correction level to maximize data capacity
        filter.setValue("L", forKey: "inputCorrectionLevel")

        guard let outputImage = filter.outputImage else {
            print("QRCodeGen: Filter outputImage is nil")
            return Image(systemName: "xmark.octagon")
        }

        // Scale up the image because it's tiny by default
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

        // Flip for macOS coordinate system
        #if os(macOS)
        let transformedImage = scaledImage.transformed(by: CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -scaledImage.extent.height))
        #else
        let transformedImage = scaledImage
        #endif

        guard let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) else {
            print("QRCodeGen: Failed to create CGImage")
            return Image(systemName: "xmark.octagon")
        }

        print("QRCodeGen: Successfully created QR code image")
        #if os(iOS)
        return Image(uiImage: UIImage(cgImage: cgImage))
        #else
        return Image(nsImage: NSImage(cgImage: cgImage, size: NSSize(width: cgImage.width, height: cgImage.height)))
        #endif
    }
}

#if os(macOS)
extension NSImage {
    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let tiff = self.tiffRepresentation else { return nil }
        guard let bitmap = NSBitmapImageRep(data: tiff) else { return nil }
        return bitmap.representation(using: .jpeg, properties: [.compressionFactor: compressionQuality])
    }
}
#endif
