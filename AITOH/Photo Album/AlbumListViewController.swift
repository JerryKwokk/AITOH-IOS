//
//  AlbumListViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {

    var albums: [Album] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
        albums = createArray()
        print(albums.count)
        // Do any additional setup after loading the view.
    }
    
    func createArray() -> [Album]{
        let album1 = Album(id: "1", title: "Osaka", bgImage: UIImage(named: "album1.png")!, imagePath: "test" , count: 9, create_date: "7 Jan 2020")
        let album2 = Album(id: "2", title: "Cat", bgImage: UIImage(named: "album0.png")!, imagePath: "test" , count: 20, create_date: "23 Dec 2020")
        print("creat Array")
        for a in albums{
            print(a.id)
        }
        
        return [album1, album2]
        
    }
    @IBAction func btnCancelClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion:nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
        cell.setAlbum(album: album)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "AlbumDetailViewController") as? AlbumDetailViewController
        vc?.album = albums[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    

}
