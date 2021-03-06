//
//  YLThumbnailCell.swift
//  YLImagePickerController
//
//  Created by yl on 2017/8/30.
//  Copyright © 2017年 February12. All rights reserved.
//

import UIKit

protocol YLThumbnailCellDelegate: NSObjectProtocol {
    
    func epPhotoTagBtnHandle(_ assetModel:YLAssetModel)
    func epImageViewHandle(_ assetModel:YLAssetModel)
    
}

class YLThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var photoTagBtn: UIButton!
    
    @IBOutlet weak var tapBtn: UIButton!
    
    weak var delegate: YLThumbnailCellDelegate?
    
    var assetModel: YLAssetModel?
    
    override func awakeFromNib() {
        photoImageView.contentMode = UIViewContentMode.scaleAspectFill
        photoImageView.clipsToBounds = true
        
        photoTagBtn.isUserInteractionEnabled = false
        
        photoImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(YLThumbnailCell.imageViewHandle))
        photoImageView.addGestureRecognizer(tap)
    }
    
    func updateAssetModel(_ assetModel: YLAssetModel,isOneChoose: Bool) {
        self.assetModel = assetModel
        
        photoImageView.image = assetModel.thumbnailImage
        
        if isOneChoose == true {
            
            photoTagBtn.isHidden = true
            tapBtn.isHidden = true
            
        }else {
            
            if assetModel.isSelected == true {
                
                let image = UIImage.init(named: "photo_selected")
                photoTagBtn.setBackgroundImage(image, for: UIControlState.normal)
                photoTagBtn.setTitle(String(assetModel.selectedSerialNumber), for: UIControlState.normal)
                
            }else {
                
                let image = UIImage.init(named: "photo_no_selected")
                photoTagBtn.setBackgroundImage(image, for: UIControlState.normal)
                photoTagBtn.setTitle("", for: UIControlState.normal)
                
            }
            
        }
        
    }
    
    @IBAction func photoTagBtnHandle(_ sender: Any) {
        if let assetModel = self.assetModel {
            delegate?.epPhotoTagBtnHandle(assetModel)
        }
    }
    
    func imageViewHandle() {
        if let assetModel = self.assetModel {
            delegate?.epImageViewHandle(assetModel)
        }
    }
}
