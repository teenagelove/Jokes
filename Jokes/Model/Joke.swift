struct Joke: Decodable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}
