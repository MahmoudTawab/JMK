//
//  API.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 05/12/2021.
//


import FirebaseFirestore

    let defaults = UserDefaults.standard

    func LodBaseUrl()  {
    Firestore.firestore().collection("API").document("IOS").addSnapshotListener { (querySnapshot, err) in
    if let err = err {
    print(err.localizedDescription)
    return
    }
    guard let data = querySnapshot?.data() else {return}
    DispatchQueue.main.async {
    let DebugBase = data["DebugBaseUrl"] as? String
    let ReleaseBase = data["ReleaseBaseUrl"] as? String
    let WhatsApp = data["WhatsAppNumber"] as? String
        
    defaults.set(DebugBase, forKey: "API")
    
    defaults.set(ReleaseBase, forKey: "Url")
    defaults.set(WhatsApp, forKey: "WhatsApp")
    }
    }
    }


    ///

    let GetUsersToken = "Token/GetUsersToken"

    let AllIndestry = "Phone/GetAllIndestry"

    let CreateNewSupplier = "Phone/CreateNewSupplier"

    let S_login = "Phone/S_login"

    let PhoneloginSocial = "Phone/S_loginSocial"

    let CreateNewAccount = "Phone/CreateNewAccount"

    let GetGuestMainScreen = "Phone/S_GetGuestMainScreen"

    let SendSms = "Phone/S_SendSms"

    let GetMainScreen = "Phone/S_GetMainScreen"

    let GetLastUpdateDetails = "Phone/S_GetLastUpdateDetails"

    let GetNotifications = "Phone/S_GetNotifications"

    let DeleteNotifications = "Phone/S_DeleteNotifications"

    let PhoneAddCalendar = "Phone/S_AddCalendar"

    let GetCalendarEvent = "Phone/S_GetCalendarEvent"

    let ChangeProfilePicture = "Phone/S_ChangeProfilePicture"

    let PhoneGetProfile = "Phone/S_GetProfile"

    let UpdateProfile = "Phone/S_UpdateProfile"

    let PhoneAddContactUs = "Phone/S_AddContactUs"

    let PhoneGetPrivacyPolicy = "Phone/S_GetPrivacyPolicy"

    let PhoneGetTermsOfService = "Phone/S_GetTermsOfService"

    let AddNewPlace = "Phone/S_AddNewPlace"

    let GetSavedPlaces = "Phone/S_GetSavedPlaces"

    let DeletePlace = "Phone/S_DeletePlace"

    let GetPlaceDetails = "Phone/S_GetPlaceDetails"

    let UpdatePlaceDetails = "Phone/S_UpdatePlaceDetails"

    let GetNotificationsSettings = "Phone/S_GetNotificationsSettings"

    let UpdateNotificationsSettings = "Phone/S_UpdateNotificationsSettings"

    let AddEventFedback = "Phone/S_AddMyEventFeedback"

    let GetEventCategory = "Phone/S_GetEventCategory"

    let GetEventPreferencesDetails = "Phone/S_GetEventPreferencesDetails"

    let PhoneAddEvent = "Phone/S_AddEvent"

    let GetMyEvents = "Phone/S_GetMyEvents"

    let DeleteEvent = "Phone/S_DeleteEvent"

    let GetWeddingPackages = "Phone/S_GetWeddingPackages"

    let GetMenuCategories = "Phone/S_GetMenuCategories"

    let GetSubCategory = "Phone/S_GetSubCategory"

    let GetCategoryItems = "Phone/S_GetCategoryItems"

    let AddNewFolder = "Phone/S_AddNewFolder"

    let GetSavedFolder = "Phone/S_GetSavedFolder"

    let AddItemSavedFolder = "Phone/S_AddItemSavedFolder"

    let UpdateSavedFolder = "Phone/S_UpdateSavedFolder"

    let DeleteSavedFolder = "Phone/S_DeleteSavedFolder"

    let GetWeddingPackagesDetils = "Phone/S_GetWeddingPackagesDetils"

    let GetItemDetils = "Phone/S_GetItemDetails"

    let AddWeddingPackagesToCart = "Phone/S_AddWeddingPackagesToCart"

    let SetViewStory = "Phone/S_SetViewStory"

    let DeleteSavedItemFromFolder = "Phone/S_DeleteSavedItemFromFolder"

    let AddItemToCart = "Phone/S_AddItemToCart"

    let DeleteItem = "Phone/S_DeleteItem"

    let GetOurStory = "Phone/S_GetOurStory"

    let GetHowItWorks = "Phone/S_GetHowItWorks"

    let GetWhatWeOffer = "Phone/S_GetWhatWeOffer"

    let GetCartDetils = "Phone/S_GetCartDetils"

    let DeletePackages = "Phone/S_DeletePackages"

    let DeleteSubPackages = "Phone/S_DeleteSubPackages"

    let AddSelectPlace = "Phone/S_AddSelectPlace"
