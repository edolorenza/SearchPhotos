//
//  PhotosCell.swift
//  PhotoSearch
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit
import SDWebImage

struct PhotosCellViewModel {
    
    var result: String
    
    var imageUrl: URL? {
        return URL(string: result)
    }
}


class PhotosCell: UICollectionViewCell {
    //MARK: -properties
    
    var viewModel: PhotosCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let photosResult: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "house")
        iv.clipsToBounds = true
        return iv
    }()
    
 
    //MARK: -Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    func setupView() {
        addSubview(photosResult)
        self.addSubview(photosResult)
        photosResult.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8)
        photosResult.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        photosResult.layer.cornerRadius = 10
    }
    func configure(){
        guard let viewModel = viewModel else { return }
        photosResult.sd_setImage(with: viewModel.imageUrl)
    }}

