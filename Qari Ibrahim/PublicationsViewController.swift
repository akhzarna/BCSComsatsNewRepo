//
//  PublicationsViewController.swift
//  Qari Ibrahim
//
//  Created by Muhammad Amir on 4/3/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import Alamofire

class PublicationsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var qaidyViewTbl: UIView!
    @IBOutlet weak var booksViewTbl: UIView!
    @IBOutlet weak var slidesViewTbl: UIView!
    
    @IBOutlet weak var PublicationSlidesTableview: UITableView!
    @IBOutlet weak var PublicationQaidyTableview: UITableView!
    @IBOutlet weak var PublicationBooksTableview: UITableView!
    var optionSelected = 0
    var myApiArray = [PublicationPDF]()
    var objArray = [AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var todoEndpoint : String = ""
        //API calling

            var booksApi = "http://channelsmedia.net/quranapp/api/publication/1"
        
            var qaidyApi = "http://channelsmedia.net/quranapp/api/publication/2"
        
            var slidesApi = "http://channelsmedia.net/quranapp/api/publication/3"
        
        
        
        Alamofire.request(booksApi)
            .responseJSON { response in
                // check for errors
                
                let arrAccess = response.result.value as! [AnyObject]
                print("response", arrAccess)
                self.myApiArray = PublicationPDF.PopulateArray(array: arrAccess as! [[String : Any]])
                
                //reloading table after getting data
                self.PublicationBooksTableview.reloadData()
                self.PublicationQaidyTableview.reloadData()
                self.PublicationSlidesTableview.reloadData()
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
        }
        
        
        
        self.booksViewTbl.layer.cornerRadius = 20.0
        self.qaidyViewTbl.layer.cornerRadius = 20.0
        self.slidesViewTbl.layer.cornerRadius = 20.0
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let Nurows = self.myApiArray.count
        print("count====", Nurows)
        return Nurows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == PublicationBooksTableview
        {
            let identifier="PublicationBooksTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PublicationBooksTableViewCell
            
            let pdfList = self.myApiArray[indexPath.row]
            cell.booksTitleLbl.text = pdfList.title
            
//            print("here it is===", (self.myApiArray[indexPath.row] as AnyObject)["title"] as? String)
//            cell.booksTitleLbl.text = (self.myApiArray[indexPath.row] as AnyObject)["title"] as? String;
            
            return cell
        }
        else if tableView == PublicationQaidyTableview
        {
            let identifier="PublicationQaidyTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PublicationQaidyTableViewCell
            
            
            cell.qaidyTitleLbl.text = (self.myApiArray[indexPath.row] as AnyObject)["title"] as? String;
            
            return cell
        }
        else if tableView == PublicationSlidesTableview
        {
            let identifier="PublicationSlidesTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PublicationSlidesTableViewCell
            
            
            cell.slidesTitleLbl.text = (self.myApiArray[indexPath.row] as AnyObject)["title"] as? String;
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print("data -====", (self.myApiArray[indexPath.row] as AnyObject)["video_link"] as? String)
        let pdfViewController = self.storyboard?.instantiateViewController(withIdentifier: "PdfReaderViewControllerID") as! PdfReaderViewController
        let objectList = self.myApiArray[indexPath.row]
        print("pdf urlll==", objectList.file)
        pdfViewController.pdfURL = objectList.file      
        self.navigationController?.pushViewController(pdfViewController, animated: true)
        
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlayerViewControllerID") as? PlayerViewController
//        vc?.dataArray = (self.myApiArray[indexPath.row] as! [String : AnyObject]) as [String : AnyObject];
//        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
