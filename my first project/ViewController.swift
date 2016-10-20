//
//  ViewController.swift
//  my first project test
//
//  Created by vishal shah on 18/10/16.
//  Copyright © 2016 vishal shah. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UISearchBarDelegate{

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemon = [Pokemon]()
    var filteredpokemon = [Pokemon]()
    var inSearchMode = false
    var musicplayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio()
    {
       let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicplayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path) as URL)
            musicplayer.prepareToPlay()
            musicplayer.numberOfLoops = -1
            musicplayer.play()
            
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell   {
            
            
            let poke: Pokemon!
            if inSearchMode {
                poke = filteredpokemon[indexPath.row]
            }
            else
            {
                poke = pokemon[indexPath.row]
            }
            cell.configurecell(pokemon: poke)
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredpokemon.count
        }
        else
        {
            return pokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    

    @IBAction func musicbuttonclick(_ sender: UIButton) {
     
        if musicplayer.isPlaying{
            musicplayer.pause()
            sender.alpha = 0.2
        }
        else
        {
            musicplayer.play()
            sender.alpha = 1.0
            
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" || searchBar.text == nil
        {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        }
        else
        {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredpokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
        
    }
}

