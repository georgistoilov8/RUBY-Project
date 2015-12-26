require 'rexml/document'
require 'json'
require 'csv'

class Result
  attr_accessor :word_counter
  attr_accessor :marks

  def initialize(word_counts, marks_count)
    @marks = marks_count
    @word_counter = word_counts
  end

  def to_csv
    CSV.open('first_sort.csv', 'a', {quote_char:" "}) do |csv|
			sorted_array = @word_counter.sort_by { |key, value| [-value, key] }
      sorted_array.each do |key, value|
        #puts "#{key},#{value}"
        csv << [key,value]
      end
		  if @marks != 0
				#puts "\"marks\",#{@marks}"
        csv << ['Marks', @marks]
      end
    end

	end

  def to_json
    hash = { 'marks' => @marks, 'words' => @word_counter }
    #puts JSON.pretty_generate(json)
    File.open('result.json', 'w') do |json|
      json << JSON.pretty_generate(hash)
   end
  end

  def to_xml
    formatter = REXML::Formatters::Pretty.new
    my_xml = REXML::Document.new('')
    words_counter = my_xml.add_element('word-counts')
    marks = words_counter.add_element('marks').add_text "#{@marks}"
    words = words_counter.add_element('words')
    @word_counter.each do |key, value|
      words.add_element('word','count' => value).add_text "#{key}"
    end
    formatter.compact = true
    File.open("result.xml", 'w') do |xml|
      xml << my_xml
    end
  end
end
