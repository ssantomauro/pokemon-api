# README

**IMPORTANT**: this project is a coding challenge developed for an interview. The requirements were explicitly specified from the company.

## Project setup

To setup the local database, please follow the steps:

- `bundle install`
- `bundle exec rails db:create`
- `bundle exec rails db:migrate`
- `bundle exec rake imports:pokemons` (it will import 150 pokemons from an external API)

If you want to import less than 150 pokemon you can run the following:

- `bundle exec rake "imports:pokemons[n]"`

## Postman

Import the Postman collection that you can find into the folder `postman`. You can use it to invoke all the endpoints created.

Then, create the Environment adding the following variables:

- `base_url` => http://localhost:3000 (or equivalent)
- `access_token` => Empty (it will be filled automatically after the Sign In)

## Development notes

In this section, I'll summarize some of decisions made and toughts I had during the development process (feature by feature). I hope can facilitate the review on the interviewers.

### Requirements

I had an initial doubt when I read "Pokemon JSON API" because I thought you could mean `json:api` (the specification). But I developed a REST API because all the JSON responses were defined by the exercise. I hope I interpreted correctly.

### User Authentication & Store Pokemon

The only think was not clear to me was the `api_token` field. Reading the exercise I had these thoughts:

- If the `api_token` is generated after the login (as specified) the concept is the same of the Authentication by an Access Token (which I developed), but in this case it's not correct saving the access_token. It's not 100% a mistake, it's just useless and less secure. The Access Token should be sent only through the requests.
- If the `api_token` has to be persisted, it means that could be something like an `api_key` used to trace the user and the operation performed (and many other things). But in this case the api_key should be generated only once, after the Sing Up.

Since the most used way to perform the authentication is the first point, I decided to proceed with that solution.

### List & Show Pokemon

I found unusual having the same endpoint with two different input types (Number or String) because it makes the Rest API less clear. A different solution could be to develop a second endpoint, for example `/api/pokemons/name/:name`.

However I developed what requested from the exercise, but as explained in the comments I'm not 100% sure I really got it.

### Allow Users to capture a Pokemon

Here the only issue I found was the `level` implementation, probably due to my total ignorance of the Pokemons world. I couldn't find a precise way to calculate the level and I still don't know if Pokemon = Pokemon Go :)

### Provide Admin CMS that allows creation of custom pokemon

Here the only doubt I had was related to the "Admin CMS". Initially I thought I had to implement the UI using the Rails Views, but I decided to continue developing a "pure" Rest API because of the initial sentence I found under the section **Requirements**: "_Your task is to create a custom Pokemon JSON API_".

However, if you meant I had to develop the views for the Pokemon Creation, I try to summarize the main things to do on my code (it won't be 100% accurate):

- the Rails project should not be crated with the option `--api`, so the `ApplicationController` extends the `ActionControler::Base`
- create an `ApiController` into the folder `controllers/api` which extends `ActionControler::API`
- all the controller classes should extend ApiController apart from The `Admin::PokemonsController` that has to extend `ApplicationController`
- create the View for the Pokemon creation (`new.html.erb` file)
- the `Admin::PokemonsController` doesn't have to render a JSON, but has to use the `format.html` and render the object persisted (for example `@pokemon`) that will be "shsred" with the View for the ui rendering

I know it's not accurate, but it's just a high level description of the steps to keep in mind.

## Lint

I haven't used `rubocop` for this example project, but for sure it's something to add to have a better code.

## Greetings

Thanks for the code challenge ;)