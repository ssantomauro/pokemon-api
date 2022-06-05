require('rails_helper')

Rails.application.load_tasks

# NOTE for the interviewers
#
# I developed this test just to demonstrate how to stub the external HTTP requests
# which was one of the main concepts, but to be honest it doesn't make much sense.
# In a real project I wouldn't develop it because of some reasons:
#
# 1) The rake task is not actually a script we would run many times, it's just the first import
# 2) The test is mainly based on JSONs mocked that probably make the difference in a real environment
RSpec.describe('imports', type: :tasks) do
  describe('pokemons') do
    # I'm only testing the case with the argument '3' to simplify the rspec.
    # Without argument (default=150) is perfectly the same,
    # it doesn't make any sense to test both
    before do
      pokemons_json = JSON.parse(File.read(File.join(self.class.fixture_path, 'files/pokemons.json')))
      stub_request(:get, "https://pokeapi.co/api/v2/pokemon?limit=3")
        .to_return(status: 200, body: pokemons_json.to_json, headers: {})

      pokemons_json['results'].each do |pokemon_json|
        pokemon_url = pokemon_json['url']
        pokemon_id = pokemon_url.split('/').last

        json = JSON.parse(File.read(File.join(self.class.fixture_path, "files/pokemon_#{pokemon_id}.json")))
        stub_request(:get, pokemon_url)
          .to_return(status: 200, body: json.to_json, headers: {})
      end
    end

    it('creates the Pokemons and Types') do
      Rake::Task['imports:pokemons'].invoke('3')

      pokemon = Pokemon.find_by_name('bulbasaur')
      expect(pokemon).to_not be_nil
      expect(pokemon.types.map(&:name)).to match(%w[grass poison])

      pokemon = Pokemon.find_by_name('ivysaur')
      expect(pokemon).to_not be_nil
      expect(pokemon.types.map(&:name)).to match(%w[grass ghost])

      pokemon = Pokemon.find_by_name('venusaur')
      expect(pokemon).to_not be_nil
      expect(pokemon.types.map(&:name)).to match(%w[electric poison])

      expect(Type.all.map(&:name)).to match(%w[grass poison ghost electric])
    end
  end
end
