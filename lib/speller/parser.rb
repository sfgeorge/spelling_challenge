
module Speller
  class Parser
    def initialize(filename)
      @filename = filename
    end

    def parse
      puts "Hey I have the file named #{@filename}"

      contents = File.readlines(@filename)
      number_of_cases = contents.first.to_i

      puts "I have #{number_of_cases} test cases!"

      1.upto number_of_cases do |case_number|
        spelling = contents[4 * case_number - 2]
        suggestion1 = contents[4 * case_number -1 ]
        suggestion2 = contents[4 * case_number]
        suggestion = suggest(spelling, suggestion1, suggestion2)
        puts suggestion
      end
      nil
    end

    def suggest(spelling, suggestion1, suggestion2)
      ## puts spelling, suggestion1, suggestion2
      return suggestion1 if spelling.eql? suggestion1
      return suggestion2 if spelling.eql? suggestion2

      relevance1 = grade(spelling, suggestion1)
      relevance2 = grade(spelling, suggestion2)
      if relevance2 > relevance1
        return suggestion2
      else
        return suggestion1
      end
    end

    def grade(word1, word2)
      score1 = scan_right(word1, word2)
      score2 = scan_right(word2, word1)
      [score1, score2].max
    end

    def scan_right(word1, word2)
      score = 0

      #print "(#{word1}<->#{word2} "

      word1.each_char do |char|
        break if word2.empty?

        position = word2.index(char)
        if position
          score += 1
          #puts "position is #{position.inspect}"
          word2 = word2[position + 1, word2.size]
        end
      end

      #puts "has a score of #{score}"

      score
    end


=begin
    def parse_old
      puts "Hey I have the file named #{@filename}"

      number_of_cases = nil
      File.readlines(@filename).each do |line|
        if number_of_cases.empty
          number_of_cases = line.to_i
        end
      end
    end
=end
  end
end