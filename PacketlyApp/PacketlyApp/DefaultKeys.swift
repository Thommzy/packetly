//
//  DefaultKeys.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var isVan: DefaultsKey<Bool> { return .init("isVan", defaultValue: false)}
    var isLorry: DefaultsKey<Bool> { return .init("isLorry", defaultValue: false)}
    var isLoggedIn: DefaultsKey<Bool> { return .init("isLoggedIn", defaultValue: false)}
    var token: DefaultsKey<String> { return .init("token", defaultValue: "") }
    var savedStateArray: DefaultsKey<[String]> {return .init("getSelectedTab", defaultValue: [""])}
    var savedUserId: DefaultsKey<String> { return .init("savedUserId", defaultValue: "") }
    var savedUserFullName: DefaultsKey<String> { return .init("savedUserFullName", defaultValue: "") }
    var savedUserPhoneNumber: DefaultsKey<String> { return .init("savedUserPhoneNumber", defaultValue: "") }
    var savedUserEmail: DefaultsKey<String> { return .init("savedUserEmail", defaultValue: "") }
}
