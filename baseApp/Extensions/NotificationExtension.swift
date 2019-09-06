//
//  NotificationExtension.swift
//  Yopter
//
//  Created by Yoptersys on 5/23/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import UIKit
import Foundation

extension Notification.Name{
    static let rightMenuNotificationName = Notification.Name("rightMenuNotificationName")
    static let leftMenuNotificationName = Notification.Name("leftMenuNotificationName")
    static let filterMapNotificationName = Notification.Name("filterMapNotificationName")
    static let offerFromMapNotificationName = Notification.Name("offerFromMapNotificationName")
    static let reinstateBackgroundTaskName = Notification.Name("reinstateBackgroundTask")
    static let showFavoritesNotificationName = Notification.Name("showFavoritesNotificationName")
    static let dismissReportNotificationName = Notification.Name("dismissReport")
    static let deleteCellNotificationName = Notification.Name("deleteCell")
    static let updateCellNotificationName = Notification.Name("updateCell")
    static let changeLogoNotificationName = Notification.Name("changeLogo")
    static let reloadFeedNotificationName = Notification.Name("reloadFeedAfterPermission")
    static let setMapAnnotation = Notification.Name("setMapAnnotation")
    static let closeOfferDetail = Notification.Name("closeAnnotation")
    static let loadMapToStore = Notification.Name("loadMapToStore")
    static let notificationReceived = Notification.Name("notificationReceived")
    static let sonicNotification = Notification.Name("sonicNotification")
    static let startBeacons = Notification.Name("startBeacons")
    static let startMessaging = Notification.Name("startMessaging")
    static let articlesNotification = Notification.Name("articlesNotification")
    static let favoriteArticlesNotification = Notification.Name("favoriteArticlesNotification")
    static let articleLeftMenuNotification = Notification.Name("articleLeftMenuNotification")
    static let favoriteArticleLeftMenuNotification = Notification.Name("favoriteArticleLeftMenuNotification")
    static let articleReceivedNotification = Notification.Name("articlesReceivedNotification")
    static let closeOfferDetailForANotification = Notification.Name("closeOfferDetailForANotification")
    static let AppActualizadaMessaging = Notification.Name("appActualizadaMessaging")
}
extension NotificationCenter {
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}
