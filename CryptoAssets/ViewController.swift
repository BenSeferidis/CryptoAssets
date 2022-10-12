//
//  ViewController.swift
//  CryptoAssets
//
//  Created by Ben Seferidis on 10/10/22.
//
//We need a class API Caller
//We need a UI to show the data
//mvvm(model-view-viewmodel)pattern maybe?


import Foundation
import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    //ftiaxno to tableview pou tha emfanizo ta dedomena
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    @IBOutlet weak var GetIn: UIButton!
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    //ftiaxno methodo gia na pairno to value int kai na to dino os string gia na to emfaniso kato
    static let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()
    
//    //kano enan array gia ola ta icons tou JSON
    var icons = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " Crypto Assets "
        view.addSubview(tableView)
        tableView.dataSource = self //method to generate cells,header and footer before they are displaying
        tableView.delegate = self //method to provide information about these cells, header and footer ....
        
        
        APICaller.shared.parseJSON{ [weak self] result in
            switch result{
            case.success(let models):
                
                self?.viewModels = models.compactMap({ model in
                    //Number Formatter for id gt einai int kai oxi string
                    let id = model.id
                    let formatter = ViewController.numberFormatter
                    let id_string = formatter.string(from: NSNumber(value: id))
                    
                    let iconUrl = URL(
                        string:
                            APICaller.shared.icons.filter({ icon in
                                icon.image_url == model.image_url
                            }).first?.image_url ?? "")
                    
                   return  CryptoTableViewCellViewModel(
                    name: model.name,
                    id: id_string ?? "N/A",
                    image:model.image_url,
                    iconUrl: iconUrl
                    )
                })
                
//kanoume autorefresh ta data
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print("Error :\(error)")
                }
        }
    }
    
//    func downloadJSON(completed: @escaping () -> () ){
//        guard let url  = URL(string: "https://public.arx.net/~chris2/nfts.json")else{
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, err in
//            //proxorame mono an den paro error
//            if err == nil{
//                do{
//                    self.icons = try JSONDecoder().decode([Crypto].self, from: data!)
//                }catch{
//                    print("error fetching data from api")
//                }
//            }
//
//            DispatchQueue.main.async{
//                completed()
//            }
//        }.resume()
//    }
    
//make a frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
//orizo ton arithmo ton rows tou table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) ->Int {
        return viewModels.count
    }
//gemizo ta rows tou table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier,
            for: indexPath
        )as? CryptoTableViewCell
        else{
            fatalError()
            //print("something did not go well with identifier")
        }

    
        
        //cell.textLabel?.text = "Hello Wolrd"
 
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}
    
    


