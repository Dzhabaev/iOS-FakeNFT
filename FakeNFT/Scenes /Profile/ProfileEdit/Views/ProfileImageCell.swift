//
//  ProfileItemCell.swift
//  FakeNFT
//
//  Created by Chalkov on 06.05.2024.
//

import UIKit
import CoreImage
import Kingfisher

final class ProfileImageCell: UITableViewCell, ReuseIdentifying {
    
    private var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Сменить фото"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 45).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.font = UIFont.medium
        label.textColor = .white
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        let image = UIImage(named: "avatar")
        imageView.image = makeMonochrome(image)
        
        return imageView
    }()
    
    func makeMonochrome(_ image: UIImage?) -> UIImage? {
        
        if let currentCGImage = image?.cgImage {
            
            let currentCIImage = CIImage(cgImage: currentCGImage)
            let filter = CIFilter(name: "CIColorMonochrome")
            filter?.setValue(currentCIImage, forKey: "inputImage")
            filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

            filter?.setValue(1.0, forKey: "inputIntensity")
            if let outputImage = filter?.outputImage {
                let context = CIContext()
                
                if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }
        return nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ profile: Profile?) {

        guard let url = URL.init(string: profile?.avatar ?? "") else { return }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
                
            case .success(let imageResult):
                self.photoImageView.image = self.makeMonochrome(imageResult.image)
                self.photoImageView.layer.cornerRadius = 35
                self.photoImageView.clipsToBounds = true
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViews() {
        selectionStyle = .none
        [photoImageView, photoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            photoLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            photoLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
        ])
    }
}
