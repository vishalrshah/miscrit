//
//  Pokemon.swift
//  my first project
//
//  Created by vishal shah on 20/10/16.
//  Copyright © 2016 vishal shah. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name;
    }
    
    var pokedexId: Int {
        return _pokedexId;
    }
    
    public init(name: String,pokedexId:Int)
    {
        self._name=name
        self._pokedexId=pokedexId
    }
}
