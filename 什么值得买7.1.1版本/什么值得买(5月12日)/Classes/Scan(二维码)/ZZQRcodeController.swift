//
//  ZZQRcodeController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/10/25.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

import UIKit
import AVFoundation
class ZZQRcodeController: UIViewController {
    let headTitle = "对准二维码/条形码到框内即可扫描"
    
    lazy var device: AVCaptureDevice = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        return device!
    }()
    var input: AVCaptureDeviceInput?
    lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    lazy var qrCodeSession: AVCaptureSession = {
        let qrCodeSession = AVCaptureSession()
        return qrCodeSession
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "二维码/条形码"
        view.backgroundColor = UIColor.white
        
        do {
            input = try AVCaptureDeviceInput.init(device: device)
        } catch let error as NSError{
            print("AVCaptureDeviceInput(): \(error)")
        }
        
        
        if qrCodeSession.canAddInput(input) {
            qrCodeSession.addInput(input)
        }

        for type in output.availableMetadataObjectTypes {
            print(type)
        }
        
        if qrCodeSession.canAddOutput(output) {
            qrCodeSession.addOutput(output)
        }
        output.metadataObjectTypes = ["org.iso.QRCode"]

        let previewLayer = AVCaptureVideoPreviewLayer.init(session: qrCodeSession)
        
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
        
        qrCodeSession.startRunning()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ZZQRcodeController: AVCaptureMetadataOutputObjectsDelegate{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
    }
    
}
