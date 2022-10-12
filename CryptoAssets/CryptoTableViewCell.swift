//
//  CryptoTableViewCell.swift
//  CryptoAssets
//
//  Created by Ben Seferidis on 11/10/22.
//

import UIKit

//ti thelo:
    //name
    //id
    //image


weak var iconImageView : UIImageView!
struct CryptoTableViewCellViewModel{
    let name:String
    let id:String
    let image:String
    let iconUrl:URL?
    
}


class CryptoTableViewCell: UITableViewCell {
    //ftiaxno mia idiotita-property identifier typou string
    static let identifier = "CryptoTableViewCell"
    
    //Subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor  = .systemGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
   
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
//        contentView.addSubview(imageLabel)
        contentView.addSubview(iconImageView)
      
        
    }
    
    //kano enan array gia ola ta icons tou JSON
    var icons = [Icon]()
    
    func downloadJSON(completed: @escaping () -> () ){
        guard let url  = URL(string: "https://public.arx.net/~chris2/nfts.json")else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, err in
            //proxorame mono an den paro error
            if err == nil{
                do{
                    self.icons = try JSONDecoder().decode([Icon].self, from: data!)
                }catch{
                    print("error fetching data from api")
                }
            }
            
            DispatchQueue.main.async{
                completed()
            }
        }.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height/1.1
        iconImageView.frame = CGRect(
            x: 20,
            y: (contentView.frame.size.height-size)/2,
            width: size,
            height: size
        )
        nameLabel.sizeToFit()
        idLabel.sizeToFit()
        imageLabel.sizeToFit()
        
        nameLabel.frame = CGRect(
            x: 30 + size,
            y: 0,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
    
       
        idLabel.frame = CGRect(
            x: 30 + size,
            y: contentView.frame.size.height/2  ,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
        imageLabel.frame = CGRect(
            x: 30 + size,
            y: 0,
            width: (contentView.frame.size.width/2)-15,
            height: contentView.frame.size.height
        )
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = nil
        idLabel.text = nil
    }
    //configure
    
    func configure(with viewModel: CryptoTableViewCellViewModel){
        nameLabel.text = viewModel.name
        idLabel.text = viewModel.id
        imageLabel.text = viewModel.image
        if let url = viewModel.iconUrl{
            let task = URLSession.shared.dataTask(with: url) { [weak self] data , _ , _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(data:data)
                    }
                }
            }
            task.resume()
        }
    }
    
}
