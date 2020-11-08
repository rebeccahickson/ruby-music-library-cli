module Concerns
  module Findable
    def find_by_name(name)
      all.find { |input| input.name == name }
    end

    # rubocop:disable Rails/DynamicFindBy
    def find_or_create_by_name(search_name)
      find_by_name(search_name) || create(search_name)
    end
    #   rubocop:enable Rails/DynamicFindBy
  end
end
