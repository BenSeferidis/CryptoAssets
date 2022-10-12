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


struct CryptoTableViewCellViewModel{
    let name:String
    let id:String
    let image:String
    
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
    
   
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(imageLabel)
      
        
    }
    
    //kano enan array gia ola ta icons tou JSON
    var icons = [Crypto]()
    
    func downloadJSON(completed: @escaping () -> () ){
        guard let url  = URL(string: "https://public.arx.net/~chris2/nfts.json")else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, err in
            //proxorame mono an den paro error
            if err == nil{
                do{
                    self.icons = try JSONDecoder().decode([Crypto].self, from: data!)
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
        nameLabel.sizeToFit()
        idLabel.sizeToFit()
        imageLabel.sizeToFit()
        
        nameLabel.frame = CGRect(
            x: 25,
            y: 0,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
    
       
        idLabel.frame = CGRect(
            x: 25,
            y: contentView.frame.size.height/2  ,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
        imageLabel.frame = CGRect(
            x: 150,
            y: 0,
            width: (contentView.frame.size.width/2)-15,
            height: contentView.frame.size.height
        )
       
    }
    //configure
    
    func configure(with viewModel: CryptoTableViewCellViewModel){
        nameLabel.text = viewModel.name
        idLabel.text = viewModel.id
        imageLabel.text = viewModel.image
  
        
        
    }
    
}
