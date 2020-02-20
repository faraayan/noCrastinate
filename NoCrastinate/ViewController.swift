//
//  ViewController.swift
//  CleverStudy
//
//  Created by Fara Yan on 10/27/19.
//  Copyright © 2019 Fara Yan. All rights reserved.
//

import UIKit
var colors = [UIColor]()
var redColor = UIColor(red:1.00, green:0.93, blue:0.93, alpha:1.0)
let greenColor = UIColor(red:0.96, green:1.00, blue:0.92, alpha:1.0)
var heyThere = 0
var sectionHeaderHeight: CGFloat { 5.0 }
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var flashcardLabelName: UILabel!
    @IBOutlet weak var flashcardTable: UITableView!

    @IBAction func analytics(_ sender: Any) {
        performSegue(withIdentifier: "analytics", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return flashcardsTerm[whichFolder].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell1 = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        guard let tableFont = UIFont(name: "Avenir-Light", size: 15) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        cell1.textLabel?.font = UIFontMetrics.default.scaledFont(for: tableFont)
        cell1.textLabel?.text = flashcardsTerm[whichFolder][indexPath.row]
        let margins = UIEdgeInsets(top: 58, left: 0, bottom: 50, right: 0)
        cell1.frame = cell1.frame.inset(by: margins)
        colors = []
        for elements in remembered[whichFolder]{
            if elements == 1{
                colors.append(greenColor)
            }
            if elements == -1{
                colors.append(redColor)
            }
            if elements == 0{
                colors.append(UIColor.white)
            }
        }
        cell1.backgroundColor = colors[indexPath.row % colors.count]
        return cell1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        flashcardTable.reloadData()
        saveData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        whichFlashcard = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        //avenir title font
        guard let titleFont = UIFont(name: "Avenir-Heavy", size: 30) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        flashcardLabelName.font = UIFontMetrics.default.scaledFont(for: titleFont)
        flashcardLabelName.text = foldersName[whichFolder]
        userData = UserDefaults.standard.bool(forKey: "userData")
        if heyThere == 1{
            userDataF = true
        }
        if userData == false{
            saveData()
            heyThere = 1
        }
        flashcardTable.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete{
                flashcardsDef[whichFolder].remove(at: indexPath.row)
                flashcardsTerm[whichFolder].remove(at: indexPath.row)
                remembered[whichFolder].remove(at: indexPath.row)
                saveData()
            flashcardTable.reloadData()
        }
    }
}
