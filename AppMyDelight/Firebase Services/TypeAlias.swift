//
//  TypeAlias.swift
//  AppMyDelight
//
//  Created by vincent portier on 20/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

typealias UserCompletion = (_ user: User?) -> (Void)
typealias PostCompletion = (_ post: Post?) -> (Void)
typealias SuccessCompletion = (_ success: Bool?,  _ erreur: String?) -> (Void)
typealias HashtagCompletion = (_ hashtag: Hashtag?) -> (Void)
typealias CommentCompletion = (_ comments: Comments?) -> (Void)
typealias NotifsCompletion = (_ notifs: Notifs?) -> (Void)
typealias VideoCompletion = (_ YouTubeVideo: YtVideo?) -> (Void)


