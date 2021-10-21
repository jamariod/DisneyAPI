//
//  DisneyCharacterViewController.swift
//  DisneyAPI
//
//  Created by Jamario Davis on 10/20/21.
//

import UIKit

class DisneyCharacterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dc = [DisneyCharacters]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
 
    func loadData() {
        dc = DisneyData.getCharacters()
    }
    func filterCharacters(for searchText: String) {
        guard !searchText.isEmpty else { return }
        dc = DisneyData.getCharacters().filter {
            $0.name.lowercased().contains(searchText.lowercased()) }
    }
}

extension DisneyCharacterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dc.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "disneyCell", for: indexPath) as? DisneyCharactersCell else {
            fatalError("Could not dequeue a DisneyCharactersCell")
        }
        let disney = dc[indexPath.row]
        cell.configureCell(for: disney)
        guard let fileURL = Bundle.main.url(forResource: "disney-characters", withExtension: "json") else {
            fatalError("Could not locate json file")
        }
        
        if let imageURL = URL(string: disney.imageUrl) {
            print(imageURL)
            if let data = try? Data(contentsOf: fileURL) {
                print(data)
                cell.disneyImageView?.image = UIImage(data: data)
            }
        }
        return cell
    }
}

extension DisneyCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension DisneyCharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        filterCharacters(for: searchText)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
                //searchText is empty here
                // use loadData method to reload table
                loadData()
                return
        }
        filterCharacters(for: searchText)
    }
}
