//
//  ConvertImageToBase64.swift
//  ShareImage
//
//  Created by Asmaa on 2/29/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import SwiftUI

class ConvertImageToBase64 {
    static func convertImageToBase64(image: UIImage) -> String {
        
        let resizedImage = image.convert(toSize:CGSize(width:100.0, height:100.0), scale: UIScreen.main.scale)
        let imageData: NSData = resizedImage.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
}

extension UIImage {
    //MARK:- convenience function in UIImage extension to resize a given image
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copied!
    }
}
