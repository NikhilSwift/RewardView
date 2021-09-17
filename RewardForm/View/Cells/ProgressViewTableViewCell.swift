//
//  ProgressViewTableViewCell.swift
//  RewardForm
//
//  Created by Nikhil Desai on 29/08/21.
//

import UIKit

class ProgressViewTableViewCell: UITableViewCell {
    let progressVew = ProgressView()
    let progressViewWidth : CGFloat = 100
    let progresstitleLabel = UILabel()
    let progressImageView = UIImageView()
    var imageViewSize : CGFloat = 50
    var type : textfieldType?
    var data: ProgressData?{
        didSet{
            if let progressdata = data{
                progresstitleLabel.text = progressdata.title ?? ""
                if let imageData = progressdata.image{
                    progressImageView.image = UIImage(named: imageData)
                }else{
                    progressImageView.image = UIImage()
                }
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupcellConstraints()
    }
    
    func setupCell(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        progressVew.backgroundColor = .clear
        //
        progresstitleLabel.text = ""
        progresstitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        progresstitleLabel.textColor = .white
        //
        progressImageView.contentMode = .scaleAspectFit
    }
    
    func setupcellConstraints(){
        progressVew.translatesAutoresizingMaskIntoConstraints = false
        progresstitleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(progressVew)
        self.addSubview(progresstitleLabel)
        self.addSubview(progressImageView)
        
        progressVew.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        progressVew.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        progressVew.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        progressVew.widthAnchor.constraint(equalToConstant: progressViewWidth).isActive = true
        //
        progresstitleLabel.leadingAnchor.constraint(equalTo: self.progressVew.trailingAnchor, constant: 0).isActive = true
        progresstitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //
        progressImageView.leadingAnchor.constraint(equalTo: self.progresstitleLabel.trailingAnchor, constant: 20).isActive = true
        progressImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progressImageView.widthAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        progressImageView.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
