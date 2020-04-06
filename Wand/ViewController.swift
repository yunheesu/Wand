//
//  ViewController.swift
//  Wand
//
//  Created by Heesu Yun on 4/7/20.
//  Copyright © 2020 Heesu Yun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var spells = Spells()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        spells.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // pass data from a selected TableViewCell into houseInfo property
        if segue.identifier == "ShowDetail" {
        let destination = segue.destination as! SpellDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.spellData = spells.spellArray[selectedIndexPath.row]
        }
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells.spellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(spells.spellArray[indexPath.row].name)"
        return cell
    }
    
    
}
