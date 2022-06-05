namespace(:imports) do

  # You can specify the number of Pokemons to import using the following:
  #   $ rake "imports:pokemons[10]"
  #
  # If the argument is not specify the rake task will import 150 pokemons
  #
  desc('Initial import of Pokemons from the official API `https://pokeapi.co`')
  task(:pokemons, %i[limit] => :environment) do |_, args|
    limit = args.limit || '150'

    # As it's just an initial import performed by a rake task
    # I didn't spend so much time in validating the response,
    # improving the performance and/or handling the errors.
    #
    # For example:
    # - accessing the Hash by String key is usually less performant,
    #   but for this import is not a big difference;
    # - the HTTP status code should be checked
    # - the JSON values should be validated
    json = JSON.load(URI.open("https://pokeapi.co/api/v2/pokemon?limit=#{limit}"))

    json['results'].each do |result_json|
      pokemon_json = JSON.load(URI.open(result_json['url']))

      pokemon =
        Pokemon.create!(
          name: pokemon_json['name'], height: pokemon_json['height'],
          weight: pokemon_json['weight'], sprite_url: pokemon_json.dig('sprites', 'other', 'official-artwork', 'front_default')
        )

      pokemon_json['types'].each do |type_json|
        type_name = type_json.dig('type', 'name')
        type = Type.find_or_create_by!(id: type_name) do |t|
          t.name = type_name

          puts "Created the new Type: #{type_name}"
        end

        pokemon.types << type
      end

      puts "Created the new Pokemon: #{pokemon_json['name']}"
    end

    puts "Import completed!"
  end

end