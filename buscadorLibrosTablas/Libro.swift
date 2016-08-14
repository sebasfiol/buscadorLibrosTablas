//
//  Libro.swift
//  buscadorLibrosTablas
//
//  Created by SebasFiol on 13/8/16.
//  Copyright © 2016 SebasFiol. All rights reserved.
//

import Foundation

class Libro {
    var ISBN : String = ""
    var titulo : String = ""
    var autores : String = ""
    var portada : String = ""
    
    init (ISBN : String, titulo : String, autores : String, portada : String) {
        self.ISBN = ISBN
        self.titulo = titulo
        self.autores = autores
        self.portada = portada
    }
}