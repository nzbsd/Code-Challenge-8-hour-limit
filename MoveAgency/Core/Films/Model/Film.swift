//
//  Film.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation

struct Film: Identifiable, Codable {
    let id = UUID()
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships: [String]
    let created, edited: String
    let url: String
    var isFav: Bool = false

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, created, edited, url
    }
}

struct MockFilm {
    static let film = Film(
        title: "The Empire Strikes Back",
        episodeID: 5,
        openingCrawl: "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space....",
        director: "Irvin Kershner",
        producer: "Gary Kurtz, Rick McCallum",
        releaseDate: "1980-05-17",
        characters: [
        "https://swapi.dev/api/people/1/",
        "https://swapi.dev/api/people/2/",
        "https://swapi.dev/api/people/3/",
        "https://swapi.dev/api/people/4/",
        "https://swapi.dev/api/people/5/",
        "https://swapi.dev/api/people/10/",
        "https://swapi.dev/api/people/13/",
        "https://swapi.dev/api/people/14/",
        "https://swapi.dev/api/people/18/",
        "https://swapi.dev/api/people/20/",
        "https://swapi.dev/api/people/21/",
        "https://swapi.dev/api/people/22/",
        "https://swapi.dev/api/people/23/",
        "https://swapi.dev/api/people/24/",
        "https://swapi.dev/api/people/25/",
        "https://swapi.dev/api/people/26/"
    ], planets: [
        "https://swapi.dev/api/planets/4/",
        "https://swapi.dev/api/planets/5/",
        "https://swapi.dev/api/planets/6/",
        "https://swapi.dev/api/planets/27/"
    ], starships: [
        "https://swapi.dev/api/starships/3/",
        "https://swapi.dev/api/starships/10/",
        "https://swapi.dev/api/starships/11/",
        "https://swapi.dev/api/starships/12/",
        "https://swapi.dev/api/starships/15/",
        "https://swapi.dev/api/starships/17/",
        "https://swapi.dev/api/starships/21/",
        "https://swapi.dev/api/starships/22/",
        "https://swapi.dev/api/starships/23/"
    ],
        created: "2014-12-12T11:26:24.656000Z",
        edited: "2014-12-15T13:07:53.386000Z",
        url: "https://swapi.dev/api/films/2/")
}
