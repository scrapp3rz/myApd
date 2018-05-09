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
        let nib = UINib(nibName: YOUTUBEVIDEO_CELL, bundle: nil)
        TableView.register(nib, forCellReuseIdentifier: YOUTUBEVIDEO_CELL)
        NotificationCenter.default.addObserver(self, selector: #selector(addYtVideo), name: nil, object: nil)
        
        
        addYtVideo()
        
        TableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ytVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ytVideo = ytVideos[indexPath.row]
        let cell = YoutubeVideoCell()
        cell.textLabel?.text = ytVideo.recipeName
        return cell
    }

    
    @objc func addYtVideo() {
        ytVideos = [YtVideo]()
        

        let TarteNutella = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella)
        let TarteNutella1 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella1", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella1)
        let TarteNutella2 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella2", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella2)
        let TarteNutella3 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella3", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella3)
        let TarteNutella4 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella4", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella4)
        let TarteNutella5 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella5", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella5)
        let TarteNutella6 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella6", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella6)
        let TarteNutella7 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella7", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella7)
        let TarteNutella8 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella8", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella8)
        let TarteNutella9 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella9", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella9)
        let TarteNutella10 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella10", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella10)
        let TarteNutella11 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella11", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella11)
        let TarteNutella12 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella12", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella12)
        let TarteNutella13 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella13", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella13)
        let TarteNutella14 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella14", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella14)
        let TarteNutella15 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella15", code: "PZZ4iC1Qsbc")
        ytVideos.append(TarteNutella15)
        
        
    //    TableView.reloadData()
        
    }
    
    
    
    
    
    
    
}
 
 

