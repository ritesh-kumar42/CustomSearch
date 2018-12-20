//
//  CountryDataModel.swift
//  CountrySearch
//
//  Created by Ritesh Kumar on 17/12/18.
//  Copyright © 2018 Ritesh Kumar. All rights reserved.
//

import UIKit
import RealmSwift


typealias CountryModel = [CountryModelElement]

class CountryModelElement: Codable {
    let name: String?
    let topLevelDomain: [String]?
    let alpha2Code, alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region: Region?
    let subregion: String?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area, gini: Double?
    let timezones, borders: [String]?
    let nativeName: String?
    let numericCode: String?
    let currencies: [Currency]?
    let languages: [Language]?
    let translations: Translations?
    let flag: String?
    let regionalBlocs: [RegionalBloc]?
    let cioc: String?
    
    init(name: String?, topLevelDomain: [String]?, alpha2Code: String?, alpha3Code: String?, callingCodes: [String]?, capital: String?, altSpellings: [String]?, region: Region?, subregion: String?, population: Int?, latlng: [Double]?, demonym: String?, area: Double?, gini: Double?, timezones: [String]?, borders: [String]?, nativeName: String?, numericCode: String?, currencies: [Currency]?, languages: [Language]?, translations: Translations?, flag: String?, regionalBlocs: [RegionalBloc]?, cioc: String?) {
        self.name = name
        self.topLevelDomain = topLevelDomain
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.callingCodes = callingCodes
        self.capital = capital
        self.altSpellings = altSpellings
        self.region = region
        self.subregion = subregion
        self.population = population
        self.latlng = latlng
        self.demonym = demonym
        self.area = area
        self.gini = gini
        self.timezones = timezones
        self.borders = borders
        self.nativeName = nativeName
        self.numericCode = numericCode
        self.currencies = currencies
        self.languages = languages
        self.translations = translations
        self.flag = flag
        self.regionalBlocs = regionalBlocs
        self.cioc = cioc
    }
}

class Currency: Codable {
    let code, name, symbol: String?
    
    init(code: String?, name: String?, symbol: String?) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}

class Language: Codable {
    let iso6391: String?
    let iso6392, name, nativeName: String?
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
    
    init(iso6391: String?, iso6392: String?, name: String?, nativeName: String?) {
        self.iso6391 = iso6391
        self.iso6392 = iso6392
        self.name = name
        self.nativeName = nativeName
    }
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case empty = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

class RegionalBloc: Codable {
    let acronym: Acronym?
    let name: Name?
    let otherAcronyms: [OtherAcronym]?
    let otherNames: [OtherName]?
    
    init(acronym: Acronym?, name: Name?, otherAcronyms: [OtherAcronym]?, otherNames: [OtherName]?) {
        self.acronym = acronym
        self.name = name
        self.otherAcronyms = otherAcronyms
        self.otherNames = otherNames
    }
}

enum Acronym: String, Codable {
    case al = "AL"
    case asean = "ASEAN"
    case au = "AU"
    case cais = "CAIS"
    case caricom = "CARICOM"
    case cefta = "CEFTA"
    case eeu = "EEU"
    case efta = "EFTA"
    case eu = "EU"
    case nafta = "NAFTA"
    case pa = "PA"
    case saarc = "SAARC"
    case usan = "USAN"
}

enum Name: String, Codable {
    case africanUnion = "African Union"
    case arabLeague = "Arab League"
    case associationOfSoutheastAsianNations = "Association of Southeast Asian Nations"
    case caribbeanCommunity = "Caribbean Community"
    case centralAmericanIntegrationSystem = "Central American Integration System"
    case centralEuropeanFreeTradeAgreement = "Central European Free Trade Agreement"
    case eurasianEconomicUnion = "Eurasian Economic Union"
    case europeanFreeTradeAssociation = "European Free Trade Association"
    case europeanUnion = "European Union"
    case northAmericanFreeTradeAgreement = "North American Free Trade Agreement"
    case pacificAlliance = "Pacific Alliance"
    case southAsianAssociationForRegionalCooperation = "South Asian Association for Regional Cooperation"
    case unionOfSouthAmericanNations = "Union of South American Nations"
}

enum OtherAcronym: String, Codable {
    case eaeu = "EAEU"
    case sica = "SICA"
    case unasul = "UNASUL"
    case unasur = "UNASUR"
    case uzan = "UZAN"
}

enum OtherName: String, Codable {
    case accordDeLibreÉchangeNordAméricain = "Accord de Libre-échange Nord-Américain"
    case alianzaDelPacífico = "Alianza del Pacífico"
    case caribischeGemeenschap = "Caribische Gemeenschap"
    case communautéCaribéenne = "Communauté Caribéenne"
    case comunidadDelCaribe = "Comunidad del Caribe"
    case jāmiAtAdDuwalAlArabīyah = "Jāmiʻat ad-Duwal al-ʻArabīyah"
    case leagueOfArabStates = "League of Arab States"
    case sistemaDeLaIntegraciónCentroamericana = "Sistema de la Integración Centroamericana,"
    case southAmericanUnion = "South American Union"
    case tratadoDeLibreComercioDeAméricaDelNorte = "Tratado de Libre Comercio de América del Norte"
    case umojaWaAfrika = "Umoja wa Afrika"
    case unieVanZuidAmerikaanseNaties = "Unie van Zuid-Amerikaanse Naties"
    case unionAfricaine = "Union africaine"
    case uniãoAfricana = "União Africana"
    case uniãoDeNaçõesSulAmericanas = "União de Nações Sul-Americanas"
    case uniónAfricana = "Unión Africana"
    case uniónDeNacionesSuramericanas = "Unión de Naciones Suramericanas"
    case الاتحادالأفريقي = "الاتحاد الأفريقي"
    case جامعةالدولالعربية = "جامعة الدول العربية"
}

class Translations: Codable {
    let de, es, fr, ja: String?
    let it: String?
    let br, pt: String?
    let nl, hr: String?
    let fa: String?
    
    init(de: String?, es: String?, fr: String?, ja: String?, it: String?, br: String?, pt: String?, nl: String?, hr: String?, fa: String?) {
        self.de = de
        self.es = es
        self.fr = fr
        self.ja = ja
        self.it = it
        self.br = br
        self.pt = pt
        self.nl = nl
        self.hr = hr
        self.fa = fa
    }
}

// MARK: Convenience initializers and mutators

extension CountryModelElement {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CountryModelElement.self, from: data)
        self.init(name: me.name, topLevelDomain: me.topLevelDomain, alpha2Code: me.alpha2Code, alpha3Code: me.alpha3Code, callingCodes: me.callingCodes, capital: me.capital, altSpellings: me.altSpellings, region: me.region, subregion: me.subregion, population: me.population, latlng: me.latlng, demonym: me.demonym, area: me.area, gini: me.gini, timezones: me.timezones, borders: me.borders, nativeName: me.nativeName, numericCode: me.numericCode, currencies: me.currencies, languages: me.languages, translations: me.translations, flag: me.flag, regionalBlocs: me.regionalBlocs, cioc: me.cioc)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String?? = nil,
        topLevelDomain: [String]?? = nil,
        alpha2Code: String?? = nil,
        alpha3Code: String?? = nil,
        callingCodes: [String]?? = nil,
        capital: String?? = nil,
        altSpellings: [String]?? = nil,
        region: Region?? = nil,
        subregion: String?? = nil,
        population: Int?? = nil,
        latlng: [Double]?? = nil,
        demonym: String?? = nil,
        area: Double?? = nil,
        gini: Double?? = nil,
        timezones: [String]?? = nil,
        borders: [String]?? = nil,
        nativeName: String?? = nil,
        numericCode: String?? = nil,
        currencies: [Currency]?? = nil,
        languages: [Language]?? = nil,
        translations: Translations?? = nil,
        flag: String?? = nil,
        regionalBlocs: [RegionalBloc]?? = nil,
        cioc: String?? = nil
        ) -> CountryModelElement {
        return CountryModelElement(
            name: name ?? self.name,
            topLevelDomain: topLevelDomain ?? self.topLevelDomain,
            alpha2Code: alpha2Code ?? self.alpha2Code,
            alpha3Code: alpha3Code ?? self.alpha3Code,
            callingCodes: callingCodes ?? self.callingCodes,
            capital: capital ?? self.capital,
            altSpellings: altSpellings ?? self.altSpellings,
            region: region ?? self.region,
            subregion: subregion ?? self.subregion,
            population: population ?? self.population,
            latlng: latlng ?? self.latlng,
            demonym: demonym ?? self.demonym,
            area: area ?? self.area,
            gini: gini ?? self.gini,
            timezones: timezones ?? self.timezones,
            borders: borders ?? self.borders,
            nativeName: nativeName ?? self.nativeName,
            numericCode: numericCode ?? self.numericCode,
            currencies: currencies ?? self.currencies,
            languages: languages ?? self.languages,
            translations: translations ?? self.translations,
            flag: flag ?? self.flag,
            regionalBlocs: regionalBlocs ?? self.regionalBlocs,
            cioc: cioc ?? self.cioc
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Currency {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Currency.self, from: data)
        self.init(code: me.code, name: me.name, symbol: me.symbol)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        code: String?? = nil,
        name: String?? = nil,
        symbol: String?? = nil
        ) -> Currency {
        return Currency(
            code: code ?? self.code,
            name: name ?? self.name,
            symbol: symbol ?? self.symbol
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Language {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Language.self, from: data)
        self.init(iso6391: me.iso6391, iso6392: me.iso6392, name: me.name, nativeName: me.nativeName)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        iso6391: String?? = nil,
        iso6392: String?? = nil,
        name: String?? = nil,
        nativeName: String?? = nil
        ) -> Language {
        return Language(
            iso6391: iso6391 ?? self.iso6391,
            iso6392: iso6392 ?? self.iso6392,
            name: name ?? self.name,
            nativeName: nativeName ?? self.nativeName
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension RegionalBloc {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RegionalBloc.self, from: data)
        self.init(acronym: me.acronym, name: me.name, otherAcronyms: me.otherAcronyms, otherNames: me.otherNames)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        acronym: Acronym?? = nil,
        name: Name?? = nil,
        otherAcronyms: [OtherAcronym]?? = nil,
        otherNames: [OtherName]?? = nil
        ) -> RegionalBloc {
        return RegionalBloc(
            acronym: acronym ?? self.acronym,
            name: name ?? self.name,
            otherAcronyms: otherAcronyms ?? self.otherAcronyms,
            otherNames: otherNames ?? self.otherNames
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Translations {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Translations.self, from: data)
        self.init(de: me.de, es: me.es, fr: me.fr, ja: me.ja, it: me.it, br: me.br, pt: me.pt, nl: me.nl, hr: me.hr, fa: me.fa)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        de: String?? = nil,
        es: String?? = nil,
        fr: String?? = nil,
        ja: String?? = nil,
        it: String?? = nil,
        br: String?? = nil,
        pt: String?? = nil,
        nl: String?? = nil,
        hr: String?? = nil,
        fa: String?? = nil
        ) -> Translations {
        return Translations(
            de: de ?? self.de,
            es: es ?? self.es,
            fr: fr ?? self.fr,
            ja: ja ?? self.ja,
            it: it ?? self.it,
            br: br ?? self.br,
            pt: pt ?? self.pt,
            nl: nl ?? self.nl,
            hr: hr ?? self.hr,
            fa: fa ?? self.fa
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Array where Element == CountryModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CountryModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

