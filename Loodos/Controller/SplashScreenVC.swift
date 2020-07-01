//
//  ViewController.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 28.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenVC: UIViewController {

 
   //MARK: -- Views
    private lazy var lblWelcomeText:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 32)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   //MARK: -- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTimer()
        
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
        
        setupViews()
    }
    
    //MARK: -- Actions
    @objc func splashTimeOut(){
        
        if Reachability.isConnectedToNetwork(){
            let vc = MainScreenVC()
            self.navigationController?.pushViewController(vc, animated: true)
    
        }else {
          showAlert()
        }
    }
    
    func addTimer(){
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(splashTimeOut), userInfo: nil, repeats: false)
    }
    
    //MARK: -- Firebase Remote Config
    func setupRemoteConfigDefaults() {
        let defaultValue = ["lblWelcomeText": "" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    
    func fetchRemoteConfig(){
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
        guard error == nil else { return }
        remoteConfig.activate(completion: nil)
        self.readNewValues()
    }}
    
    func readNewValues(){
        let newLabelText = remoteConfig.configValue(forKey: "lblWelcomeText").stringValue ?? ""
        lblWelcomeText.text = newLabelText
    }
    
    
    //MARK: -- UI Arragement Methods
    fileprivate func setupViews(){
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        view.addSubview(lblWelcomeText)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        lblWelcomeText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        lblWelcomeText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func showAlert(){
        
        let alert = UIAlertController(title: "Connection Error", message: "You have no internet connection. Please retry", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.splashTimeOut()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    

}

