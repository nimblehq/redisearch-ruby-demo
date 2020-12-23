module StringExtensions
  refine String do
    def escape_special_characters
      # List of characters from https://oss.redislabs.com/redisearch/Escaping/
      # ,.<>{}[]"':;!@#$%^&*()-+=~
      pattern = %r{(\'|\"|\.|\,|\;|\<|\>|\{|\}|\[|\]|\"|\'|\=|\~|\*|\:|\#|\+|\^|\$|\@|\%|\!|\&|\)|\(|/|\-|\\)}
      gsub(pattern) { |match| '\\' + match }
    end
  end
end
