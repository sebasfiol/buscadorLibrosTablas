//
//  BuscadorLibro.swift
//  buscadorLibrosTablas
//
//  Created by SebasFiol on 12/8/16.
//  Copyright © 2016 SebasFiol. All rights reserved.
//

import UIKit

class BuscadorLibro: UIViewController {
    @IBOutlet weak var numeroISBN: UITextField!
    @IBOutlet weak var tituloLibro: UILabel!
    @IBOutlet weak var autores: UITextView!
    @IBOutlet weak var portadaLibro: UIImageView!

    @IBAction func buscarLibro(sender: AnyObject) {
        self.tituloLibro.text = ""
        self.autores.text = ""
        self.portadaLibro.image = nil
        var urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let isbn = numeroISBN.text!
        urls = "\(urls)\(isbn)"
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        if datos == nil {
            let alertController = UIAlertController(title: "Error", message:"Se ha producido un error de comunicación.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:"+isbn] as! NSDictionary
                self.tituloLibro.text = dico2["title"] as! NSString as String
                if let dico3 = dico2["authors"] as? [[String: AnyObject]] {
                    for autor in dico3 {
                        if let name = autor["name"] as? String {
                            self.autores.insertText(name+"\n")
                        }
                    }
                }
                if let dico4 = dico2["cover"] as? NSDictionary {
                    let dico5 = dico4["medium"] as! NSString as String
                    cargarImagen(dico5)
                }
            }
            catch _ {
                let alertController = UIAlertController(title: "Error", message:"Se ha producido un error en la aplicación.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        self.view.endEditing(true)
    }
    
    func cargarImagen(urlString:String) {
        let url = NSURL(string: urlString)
        let datos = NSData(contentsOfURL: url!)
        if datos != nil {
            self.portadaLibro.image = UIImage(data: datos!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tituloLibro.text = ""
        self.autores.text = ""
        self.portadaLibro.image = nil
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
