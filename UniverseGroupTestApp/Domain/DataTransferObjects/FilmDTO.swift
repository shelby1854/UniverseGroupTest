//
//  FilmDTO.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import Foundation

struct FilmDTO {
    let id: UUID
    let title: String
    let description: String
    let releaseDate: Int
}

//MARK: - Mock logic
extension FilmDTO {
    static var mockData: [FilmDTO] {
        return [
            FilmDTO(
                id: UUID(),
                title: "The Shawshank Redemption",
                description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
                releaseDate: 783216000000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Godfather",
                description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
                releaseDate: 694137600000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Dark Knight",
                description: "When the menace known as the Joker emerges, he causes chaos in Gotham City, pushing Batman to his limits.",
                releaseDate: 1216425600000
            ),
            FilmDTO(
                id: UUID(),
                title: "Pulp Fiction",
                description: "The lives of two mob hitmen, a boxer, and others intertwine in a tale of violence and redemption.",
                releaseDate: 781214400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Schindler's List",
                description: "In German-occupied Poland, Oskar Schindler saves the lives of his Jewish employees after witnessing their persecution.",
                releaseDate: 754704000000
            ),
            FilmDTO(
                id: UUID(),
                title: "Forrest Gump",
                description: "The story of Forrest Gump, a man with a low IQ but a kind heart, who witnesses key historical events.",
                releaseDate: 773068800000
            ),
            FilmDTO(
                id: UUID(),
                title: "Inception",
                description: "A thief who steals corporate secrets through dream-sharing technology is tasked with planting an idea.",
                releaseDate: 1279238400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Fight Club",
                description: "An insomniac office worker and a soap salesman form an underground fight club.",
                releaseDate: 939427200000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Matrix",
                description: "A computer hacker learns about the true nature of his reality and his role in the war against its controllers.",
                releaseDate: 922752000000
            ),
            FilmDTO(
                id: UUID(),
                title: "Goodfellas",
                description: "The story of Henry Hill and his life in the mob, covering his rise and fall.",
                releaseDate: 653356800000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Lord of the Rings",
                description: "A meek Hobbit sets out on a journey to destroy a powerful ring and save Middle-earth.",
                releaseDate: 1008806400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Star Wars: Episode IV",
                description: "Luke Skywalker joins the Rebel Alliance to defeat the Galactic Empire.",
                releaseDate: 233366400000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Silence of the Lambs",
                description: "A young FBI cadet seeks the help of a manipulative cannibal to catch another serial killer.",
                releaseDate: 665366400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Saving Private Ryan",
                description: "A group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.",
                releaseDate: 900288000000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Green Mile",
                description: "The lives of guards on Death Row are affected by one of their prisoners.",
                releaseDate: 944006400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Interstellar",
                description: "A group of astronauts travel through a wormhole in search of a new home for humanity.",
                releaseDate: 1415145600000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Lion King",
                description: "A young lion prince flees his kingdom, only to learn the true meaning of responsibility and bravery.",
                releaseDate: 773222400000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Social Network",
                description: "The story of the founding of Facebook and the lawsuits that followed.",
                releaseDate: 1285891200000
            ),
            FilmDTO(
                id: UUID(),
                title: "The Avengers",
                description: "Earth's mightiest heroes must come together to stop Loki and his alien army.",
                releaseDate: 1335830400000
            ),
            FilmDTO(
                id: UUID(),
                title: "Parasite",
                description: "A poor family schemes to become employed by a wealthy household.",
                releaseDate: 1571270400000
            )
        ]
    }
}
