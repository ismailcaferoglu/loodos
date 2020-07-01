//
//  ViewController.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 28.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import UIKit
import ProgressHUD

class MainScreenVC: UIViewController,Networkable {

    //MARK: -- Properties
    var datasource = Datasource()
    var items = [CellCompatible]()
    
    //MARK: -- Views
    fileprivate lazy var txtSearch:UITextField = {
        let tf = UITextField()
        tf.setAttributedPlaceholder(text: "Search what you want", color: .gray)
        tf.textColor = .black
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.leftPadding = 8
        tf.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ProgressHUD.animationType = .multipleCircleScaleRipple
        
        
        
        setupViews()
    }
    
    @objc func textFieldChanged(sender:UITextField) {
        
        ProgressHUD.show()
        let params = ["s":sender.text!,"apiKey":"ca51999b"]
        
        getSearchResult(parameters: params, completionHandler: { [unowned self] result, err in
            //guard let error = err else { return }
            
            guard let res = result else { return }
            res.forEach({ result in
                
                if !res.isEmpty {
                    self.items.append(SearchResultCellModel(model: result))
                   
                }else {
                    
                }
               
            })
            
            let section = CollectionViewSection(sortOrder: 0, items: self.items)
            self.datasource.sections = [section]
            self.collectionView.dataSource = self.datasource
            self.collectionView.reloadData()
            self.items.removeAll()
            ProgressHUD.dismiss()
        })
        
    }
    
     //MARK: -- UI Arragement Methods
    
    fileprivate func addEmptyImage(isBlank:Bool){
        let imgEmpty = UIImageView(frame: .zero)
        imgEmpty.contentMode = .scaleAspectFit
        imgEmpty.backgroundColor = .red
        imgEmpty.translatesAutoresizingMaskIntoConstraints = false
        
        if isBlank {
            
        }else {
            imgEmpty.removeFromSuperview()
        }
    }
    
    fileprivate func setupViews(){
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = #colorLiteral(red: 0.9222190738, green: 0.9222190738, blue: 0.9222190738, alpha: 1)
        self.collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: "SearchResultCell")
        self.collectionView.delegate = self
        self.view.addSubviews(txtSearch,collectionView)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        txtSearch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        txtSearch.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        txtSearch.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        txtSearch.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: txtSearch.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: txtSearch.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: txtSearch.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }


}

extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let object = datasource.sections[safe:indexPath.section]!.items[safe:indexPath.row]!
        return object.cellForSize(collectionView: collectionView, atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = datasource.sections[indexPath.section].items
        let item = data[indexPath.row] as! SearchResultCellModel
        let object = item.model
        
        let vc = DetailVC()
        vc.resultObject = object
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
