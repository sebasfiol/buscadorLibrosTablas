//
//  DetailViewController.swift
//  buscadorLibrosTablas
//
//  Created by SebasFiol on 12/8/16.
//  Copyright © 2016 SebasFiol. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UITextView!
    @IBOutlet weak var portada: UIImageView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let labelTitulo = self.titulo {
                labelTitulo.text = detail.valueForKey("titulo")!.description
            }
            if let textAutores = self.autores {
                textAutores.text = detail.valueForKey("autores")!.description
            }
            cargarImagen(detail.valueForKey("portada")!.description)
        }
        /*
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("titulo")!.description
            }
        }*/
    }
    
    func cargarImagen(urlString:String)
    {
        let url = NSURL(string: urlString)
        let datos = NSData(contentsOfURL: url!)
        if datos != nil {
            self.portada.image = UIImage(data: datos!)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

