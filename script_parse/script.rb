require_relative 'Word_Counter/word_counter.rb'

file = ARGV[0]
format = ARGV[1]

#if(file.include?("http://") || file.include?("https://")) it can be break so....
if(file.start_with?('https://') || file.start_with?('http://'))
  result = WordCounter.parsing_web_source file
elsif(file.include?(" "))
  result = WordCounter.parse file
else
  result = WordCounter.parsing_the_file file
end

if format == 'csv' || format == nil
  result.to_csv
  else
  if format == 'json'
    result.to_json
    else
    if format == 'xml'
      result.to_xml
    end
  end
end
