//
//  ViewController.swift
//  CustomeLoadingPage
//
//  Created by Apple on 6/1/20.
//  Copyright © 2020 NguyenDucLuu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    let background:UIView? = nil
    let logo:UIView? = nil
    var timer: Timer?
    var count:Int = 0
    var xLogo = -200
    
    let catRun:[String] = ["Run (1)","Run (2)","Run (3)","Run (4)","Run (5)","Run (6)","Run (7)","Run (8)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadIMG(_ sender: Any) {
        guard timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showLoading), userInfo: nil, repeats: true)
        
        let queue = DispatchQueue(label: "LOAD")
        queue.async {
            
            let url = URL(string: "https://traveldailymedia.com/assets/2019/09/shutterstock_1106355956.png")
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.img.image = UIImage(data: data)
                    self.offViewByID(ID: 0001)
                    self.offViewByID(ID: 0002)
                    self.offViewByID(ID: 0003)
                    self.stopTimer()
                }
            } catch {}
        
        }
        
        let TDKT:CGRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        let background:UIView = UIView(frame: TDKT)
        background.backgroundColor = UIColor.black
        background.alpha = 0.3
        background.tag = 0001
        view.addSubview(background)
        
//        logo.addSubview(<#T##view: UIView##UIView#>)
    }
    
    @IBAction func removeSUBView(_ sender: Any) {
        offViewByID(ID: 0001)
    }
    
    func offViewByID(ID:Int) {
        view.viewWithTag(ID)?.removeFromSuperview()
    }
    
    @objc func showLoading() {
        
        //turn off repeat Logo
        view.viewWithTag(0003)?.removeFromSuperview()
        
        count += 1
        
        if count == 8 {
            count = 0
        }
//        set location and width height Logo
        let imageView = UIImageView(frame: CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2.5, width: view.frame.size.width/2.5, height: view.frame.size.height/4.5)); // set as you want
        
        var image = UIImage(named: catRun[count]);
//        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        let TDKT:CGRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        let logo:UIView = UIView(frame: TDKT)
        logo.tag = 0002
        imageView.tag = 0003
        view.addSubview(logo)
        view.addSubview(imageView);
        
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

