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



class ViewController: UIViewController,  AVCaptureVideoDataOutputSampleBufferDelegate {

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
        
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
       
//
//        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: <#T##[VNImageOption : Any]#>).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("camera was able to capture a fram:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
//        let model = ??
        
//
//         let requeest = VNCoreMLRequest(model: <#T##VNCoreMLModel#>)
//         { (finishedReq, err) in
//            // perhaps check the erro
//
        
        }
//        VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    

   
}

