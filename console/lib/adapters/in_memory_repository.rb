module Adapters
  class InMemoryRepository
    def initialize(game_lookup={})
      @game_lookup = game_lookup
    end

    def generate_id
      @id = @id.to_i.next
    end

    def store(attributes)
      @game_lookup.store(attributes.fetch(:id), attributes)
    end

    def save(attributes)
      game_id = attributes.fetch(:id)
      @game_lookup.store(game_id, @game_lookup.fetch(game_id).merge(attributes))
    end

    def get(game_id)
      @game_lookup.fetch(game_id)
    end
  end
end