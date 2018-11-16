//
//  ViewController.swift
//  ClickNBuy
//
//  Created by Isaac Kim on 16/11/2018.
//  Copyright © 2018 Isaac Kim. All rights reserved.
//

import UIKit
import AVKit
import Vision



class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {

    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       captureOutput()
        print("hello")
       
        // here is where we start up the camera
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1280x720
        
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        
        previewLayer.frame = cameraView.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("camera was able to capture a fram:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model)
        { (finishReq, err) in
//            print(finishReq.results)
            
            guard let results = finishReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation =  results.first else { return }
            
            
            print(firstObservation.identifier, firstObservation.confidence)
            DispatchQueue.main.async {
                let doubleDigitConfidenceLevel = Double(firstObservation.confidence)
                self.probabilityLabel.text = firstObservation.identifier
                self.displayLabel.text = "\(Double(doubleDigitConfidenceLevel) * 100)%"
                
            }
            
            
            
        }

        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    
    }
   
}

