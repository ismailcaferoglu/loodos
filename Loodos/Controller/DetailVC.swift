//
//  DetailVC.swift
//  Loodos
//
//  Created by iMac on 30.06.2020.
//  Copyright © 2020 İsmail Caferoğlu. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
import ProgressHUD

class DetailVC: UIViewController, Networkable {

    //MARK: -- Properties
    var resultObject:SearchResult?
    
    //MARK: -- Views
    
    lazy var btnBack:UIButton = {
        let b = UIButton()
        b.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)
        b.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var imgPoster:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let url = URL(string: resultObject!.poster)
        iv.kf.setImage(with: url)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var lblTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.text = self.resultObject?.title
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblRatingTitle:UILabel = {
           let label = UILabel()
           label.textColor = .gray
           label.text = "IMDB Rating"
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblRating:UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblYearTitle:UILabel = {
           let label = UILabel()
           label.textColor = .gray
           label.text = "Year"
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblYear:UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblPlot:UILabel = {
           let label = UILabel()
           label.textColor = .darkGray
           label.font = UIFont(name: "AvenirNext-Medium", size: 16)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblDirectorTitle:UILabel = {
           let label = UILabel()
           label.textColor = .gray
           label.text = "Director"
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblDirector:UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont(name: "AvenirNext-Medium", size: 16)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblActorsTitle:UILabel = {
           let label = UILabel()
           label.textColor = .gray
           label.text = "Actors"
           label.font = UIFont(name: "AvenirNext-Medium", size: 14)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblActors:UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont(name: "AvenirNext-Medium", size: 16)
           label.lineBreakMode = .byWordWrapping
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
    }()
    
    private lazy var lblRuntimeTitle:UILabel = {
              let label = UILabel()
              label.textColor = .gray
              label.text = "Runtime"
              label.font = UIFont(name: "AvenirNext-Medium", size: 14)
              label.lineBreakMode = .byWordWrapping
              label.numberOfLines = 0
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
       }()
       
       private lazy var lblRuntime:UILabel = {
              let label = UILabel()
              label.textColor = .black
              label.font = UIFont(name: "AvenirNext-Medium", size: 14)
              label.lineBreakMode = .byWordWrapping
              label.numberOfLines = 0
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
       }()
    
    //MARK: -- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        requestMovieDetail()
    }
    
    //MARK: -- Actions
    @objc func btnBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func requestMovieDetail(){
        ProgressHUD.show()
        ProgressHUD.animationType = .multipleCircleScaleRipple
        
        let params = ["i":resultObject!.imdbID,"apiKey":"ca51999b"]
        getMovieDetail(parameters: params, completionHandler: { [unowned self] result, err in
            
            guard let res = result else { return }
            
            self.setupContent(model: res)
            ProgressHUD.dismiss()
        })
    }
    
    //MARK: -- UI Arragement Methods
    fileprivate func setupViews() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubviews(btnBack,
                              imgPoster,
                              lblTitle,
                              lblYearTitle,
                              lblYear,
                              lblRatingTitle,
                              lblRating,
                              lblRuntimeTitle,
                              lblRuntime,
                              lblPlot,
                              lblDirectorTitle,
                              lblDirector,
                              lblActorsTitle,
                              lblActors)
        setupLayout()
        
    }
        
    private func setupContent(model:Movie){
        lblPlot.text = model.plot
        lblRating.text = model.imdbRating
        lblDirector.text = model.director
        lblActors.text = model.actors
        lblYear.text = model.year
        lblRuntime.text = model.runtime
        
        
        Analytics.logEvent("movie_object", parameters: [
                                                        "title": model.title ,
                                                        "year": model.year,
                                                        "rating": model.imdbRating,
                                                        "actors": model.actors,
                                                        "director": model.director
        ])
        
    }
    
    fileprivate func setupLayout() {
        
        btnBack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        btnBack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 44).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.view.bringSubviewToFront(btnBack)
        
        imgPoster.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imgPoster.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imgPoster.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imgPoster.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.30).isActive = true
        
        lblTitle.topAnchor.constraint(equalTo: imgPoster.bottomAnchor,constant: 16).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        lblYearTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 8).isActive = true
        lblYearTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
        lblYear.topAnchor.constraint(equalTo: lblYearTitle.topAnchor).isActive = true
        lblYear.leadingAnchor.constraint(equalTo: lblYearTitle.trailingAnchor, constant: 4).isActive = true
        
        lblRatingTitle.leadingAnchor.constraint(equalTo: lblYear.trailingAnchor, constant: 16).isActive = true
        lblRatingTitle.topAnchor.constraint(equalTo: lblYear.topAnchor).isActive = true
        
        lblRating.topAnchor.constraint(equalTo: lblRatingTitle.topAnchor).isActive = true
        lblRating.leadingAnchor.constraint(equalTo: lblRatingTitle.trailingAnchor, constant: 4).isActive = true
        
        lblRuntimeTitle.topAnchor.constraint(equalTo: lblYearTitle.topAnchor).isActive = true
        lblRuntimeTitle.leadingAnchor.constraint(equalTo: lblRating.trailingAnchor, constant: 16).isActive = true
        
        lblRuntime.topAnchor.constraint(equalTo: lblRuntimeTitle.topAnchor).isActive = true
        lblRuntime.leadingAnchor.constraint(equalTo: lblRuntimeTitle.trailingAnchor, constant: 4).isActive = true
        
        lblPlot.topAnchor.constraint(equalTo: lblYearTitle.bottomAnchor, constant: 8).isActive = true
        lblPlot.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        lblPlot.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        lblActorsTitle.topAnchor.constraint(equalTo: lblPlot.bottomAnchor, constant: 16).isActive = true
        lblActorsTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
        lblActors.topAnchor.constraint(equalTo: lblActorsTitle.bottomAnchor, constant: 2).isActive = true
        lblActors.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        lblActors.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        lblDirectorTitle.topAnchor.constraint(equalTo: lblActors.bottomAnchor, constant: 16).isActive = true
        lblDirectorTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
        lblDirector.topAnchor.constraint(equalTo: lblDirectorTitle.bottomAnchor, constant: 2).isActive = true
        lblDirector.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        lblDirector.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
    }

}
