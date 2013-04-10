class SetPrices
  attr_accessor :parent_folder, :keywords
  def update
    path ||= "lib/assets/Parts"
    game_folder = "/Users/soerenlnik/Projekte/ksp_campign/"
    self.parent_folder = "#{game_folder}#{path}"
    Dir["#{parent_folder}/*/"].map do |a|
      parse_cfg(a)
    end
  end

  def parse_cfg(folder)
    file = IO.readlines("#{folder}#{part.cfg}")
    hash = to_hash(file, 0)
    return hash
  end

  def to_hash(file, index)
    hash = {}
    file.length.times do |n|
      # if we reached EOF or end of block, return built hash
      if(index = file.length or line["}"])
        return hash
      end

      # strip line of whitespaces and downcase it for string comparisons
      line = file[index].gsub(/\s+/, "").downcase

      # if line marks beginning of a block, do recursion
      if line["{"]
        # search above block for block name
        file.length.times do |i|
          pre_line = file[index - i].gsub(/\s+/, "").downcase
          unless pre_line.empty?
            # If Hash already has element with that name, add block content to array
            # otherwise, create new hash key with empty array and add block to array
            if hash.has_key?(pre_line)
              hash[pre_line] << to_hash(file, index + 1)
            else
              hash[pre_line] = [to_hash(file, index + 1)]
            end
          end
        end
      end

      # If line is a key-value pair, add value to hash under key
      if line["="]
        key_pair = line.split("=")
        hash[key_pair[0]] = key_pair[1]
      end
      index = index + 1
    end
  end
end
