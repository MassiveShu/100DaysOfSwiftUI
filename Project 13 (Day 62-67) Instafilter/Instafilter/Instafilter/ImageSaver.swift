//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Max Shu on 14.08.2022.
//

import UIKit

class ImageSaver: NSObject {
    var succesHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            succesHandler?()
        }
    }
}
