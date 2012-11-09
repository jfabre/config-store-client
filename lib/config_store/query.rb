module ConfigStore
  module Query
    def find_by_name(name)
      all(params: prefix_options).select{|x| x.name == name }.first
    end
  end
end