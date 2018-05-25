//
//  Stockage.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import FirebaseStorage

class Stockage {
    
    func addPostImage(reference: StorageReference, data: Data, completion: SuccessCompletion?) {
     //   let idUnic = UUID().uuidString
     //   Ref().myPostImages.child(idUnic)
     //   StorageReference.downloadURL(<#T##StorageReference#>)
            reference.putData(data, metadata: nil) { (meta, error) in
            if error == nil {
                reference.putData(data, metadata: nil) { (meta, error) in
                    if error == nil {
                        reference.downloadURL(completion: { (url, error) in
                            if error == nil, let urlString = url?.absoluteString {
                                completion?(true, urlString)
                            } else {
                                completion?(false, error?.localizedDescription)
                            }
                        })
                    } else {
                        completion?(false, error!.localizedDescription)
                    }
                }
                }
                /*
                if let urlString = meta?.downloadURL()?.absoluteString {
                    completion?(true, urlString)
                } else {
                    completion?(false, nil)
                }
            } else {
                completion?(false, error!.localizedDescription)
            }
        }
    */
 
    }
    }
    
    
    
    
    
    
}
