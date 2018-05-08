//
//  ytVideoController.swift
//  AppMyDelight
//
//  Created by vincent portier on 08/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class ytVideoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    var ytVideos = [YtVideo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        addYtVideo()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ytVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ytVideo = ytVideos[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = ytVideo.recipeName
        return cell
    }

    
    func addYtVideo() {
        ytVideos = [YtVideo]()
        

        let TarteNutella = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella)
        let cool = YtVideo(shortPitch: "Casseurs Flowters", recipeName: "Ils sont cools", code: "_DT-4-jJTZc")
        ytVideos.append(cool)
        let bien  = YtVideo(shortPitch: "Orelsan", recipeName: "tout va bien", code: "dq6G2YWoRqA")
        ytVideos.append(bien)
        let basique = YtVideo(shortPitch: "Orelsan", recipeName: "Basique", code: "2bjk26RwjyU")
        ytVideos.append(basique)
        let ronde = YtVideo(shortPitch: "Orelsan", recipeName: "La terre est ronde", code: "oGdhZyS2ozo")
        ytVideos.append(ronde)
        let san = YtVideo(shortPitch: "Orelsan", recipeName: "San", code: "PejyoeG_TmA")
        ytVideos.append(san)
        let seul = YtVideo(shortPitch: "Orelsan", recipeName: "Si seul", code: "cz-PLtXh7Lo")
        ytVideos.append(seul)
        let inacheves = YtVideo(shortPitch: "Casseurs Flowteurs", recipeName: "Inachevés", code: "MW1eQZ_PEb4")
        ytVideos.append(inacheves)
        

        TableView.reloadData()
        
    }
    
    
    
    
    
    
    
}
