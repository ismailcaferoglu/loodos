//
//  SearchResultCell.swift
//  Loodos
//
//  Created by İsmail Caferoğlu on 29.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import UIKit
import Kingfisher

class SearchResultCell: UICollectionViewCell, Configurable {
    
    
    private lazy var imgPoster:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var lblTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblYear:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func configureWithModel(model: SearchResult) {
        lblTitle.text = model.title
        lblYear.text = model.year
        
        let url = URL(string: model.poster)
        imgPoster.kf.setImage(with: url)
    }
    
    //MARK: -- UI Methods
    fileprivate func setupViews(){
        
        self.backgroundColor = .white
        self.addSubviews(imgPoster,lblTitle,lblYear)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        imgPoster.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgPoster.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imgPoster.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgPoster.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: imgPoster.trailingAnchor, constant: 16).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        lblYear.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        lblYear.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SearchResultCellModel:CellCompatible {
    
    var model:SearchResult
    
    var reuseIdentifier: String {
        return "SearchResultCell"
    }
    
    init(model:SearchResult) {
        self.model = model
    }
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.configureWithModel(model: model)
        return cell
    }
    
    func cellForSize(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}
