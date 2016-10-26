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
    lazy var input: AVCaptureDeviceInput = {
        let input = AVCaptureDeviceInput()
        return input
    }()
    lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
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

        output = AVCaptureMetadataOutput()

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ZZQRcodeController: AVCaptureMetadataOutputObjectsDelegate{
    
}
