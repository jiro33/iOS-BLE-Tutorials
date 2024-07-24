//
//  ViewController.swift
//  BLEScanExample
//
//  Created by Shuichi Tsutsumi on 2014/12/12.
//  Copyright (c) 2014年 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet private var textView: UITextView!

    var isScanning = false
    var centralManager: CBCentralManager!
    var centralManager2: CBCentralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セントラルマネージャ初期化
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager2 = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Actions

    @IBAction func scanButtonTapped(_ sender: UIButton) {
        if !isScanning {
            isScanning = true
            sender.setTitle("STOP SCAN", for: .normal)

            let serviceUUID = CBUUID(string: "B36F4066-2EF7-467E-832D-8CBFF563BBBB")
            centralManager.scanForPeripherals(withServices: [serviceUUID])
            centralManager2.scanForPeripherals(withServices: [CBUUID(string: "00000000-0000-0000-0000-000000000039")])
        } else {
            centralManager.stopScan()
            
            sender.setTitle("START SCAN", for: .normal)
            isScanning = false
        }
    }
}

extension ViewController: CBCentralManagerDelegate {
        
    // セントラルマネージャの状態が変化すると呼ばれる
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("state: \(central.state)")
    }

    // 周辺にあるデバイスを発見すると呼ばれる
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber)
    {
        print("発見したBLEデバイス: \(peripheral)")
        textView.text += """

        --------------------
        \(Date())
        \(peripheral)
        """
    }
}

