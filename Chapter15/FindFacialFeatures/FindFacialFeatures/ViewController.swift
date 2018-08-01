//
//  ViewController.swift
//  FindFacialFeatures
//
//  Created by Donny Wals on 17/09/2017.
//  Copyright © 2017 DonnyWals. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    let imageView = UIImageView(image: #imageLiteral(resourceName: "face_photo"))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)])
        guard let image = imageView.image?.cgImage
            else { return }
        
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        let request = VNDetectFaceLandmarksRequest(completionHandler: { request, error in
            guard let results = request.results as? [VNFaceObservation]
                else { return }
            
            for result in results where result.landmarks != nil {
                let landmarks = result.landmarks!
                
                if let faceContour = landmarks.faceContour {
                    print(faceContour.normalizedPoints)
                }
                
                if let leftEye = landmarks.leftEye {
                    print(leftEye.normalizedPoints)
                }
                
                // etc
            }
        })

        try? handler.perform([request])
    }
    
}

