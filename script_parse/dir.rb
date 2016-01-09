require 'csv'
require 'json'
require 'rubygems'

def clone rep
  `git clone #{rep}`
end

def delete_rep rep
  `rm -rf #{rep}`
end

def delete_file file_name
  `rm #{file_name}`
end

def make_svg result,name
  `ruby ../SVG_program/svg.rb #{result} #{name}`
end

format = ARGV[0]

def sort_csv csv_to_sort
	my_csv = CSV.read csv_to_sort
  my_csv.sort! do |a,b|
    if a[1].to_i == b[1].to_i
      [a[0]] <=> [b[0]]
    else
      [b[1].to_i] <=> [a[1].to_i]
    end
  end

  i = 0
	CSV.open('result.csv', 'w', {quote_char:" "}) do |csv|
    my_csv.each { |element| csv << element }
  end
end

def join_repetitive
  csv = CSV.read('result.csv')
  hash = Hash.new()

  i = 0
  csv.group_by{|row| row[0]}.values.each do |group|
      hash[i] = group.map{|r| r[1]} * ' '
      i += 1
  end

  arr = []
  count = 0
  hash.each do |key, value|
    asd = value.split(' ')
    sum = 0
    asd.each do |a|
      sum += a.to_i
    end
    arr[count] = sum
    count += 1
  end

  count = 0
  hash.each do |k, v|
    hash[k] = arr[count]
    count += 1
  end
  CSV.open('result.csv', 'w', { col_sep: "\t", force_quotes: false }) do |file|
    i = 0
    csv.group_by{|row| row[0]}.values.each do |group|
      file << [[group.first[0], hash[i]] * ',']
      i += 1
    end
  end
end


repository = nil
res_of_rep = nil
name_of_svg = nil
if(format == 'ruby')
  repository = '../ParseRepos/ruby.txt'
  res_of_rep = 'ruby.json'
  name_of_svg = 'ruby.svg'
elsif (format == 'c++')
  repository = '../ParseRepos/cplusplus.txt'
  res_of_rep = 'cpp.json'
  name_of_svg = 'cpp.svg'
elsif (format == 'java')
  repository = '../ParseRepos/java.txt'
  res_of_rep = 'java.json'
  name_of_svg = 'java.svg'
else
  raise NoMethodError, "invalid \'#{format}\' format."
end

def make_json(csv, res_of_rep)
  data = File.open('result.csv', 'r')
  occur = 0
  hash = Hash[ CSV.read('result.csv').map do |row|
    if(row[0] == 'Marks')
      occur = row[1].to_i
      [0,0]
    else
      [ row[0], row[1].to_i]
    end
  end ]

  hash["NumberOfMarksInCode"] = occur
  hash.shift
  File.open(res_of_rep, 'w') do |f|
    f << JSON.pretty_generate(hash)
  end
end

def remove_makrs csv
  File.open('SVG_result.csv', 'w+') do |outf|
    File.open(csv) do |inf|
      inf.each_line.with_index do |line, i|
        outf.write line unless i==0
      end
    end
  end
end

#delete_file 'repository.csv'
delete_file 'svg_program.svg'
sum = 0
count = 0
File.open('rep.txt', 'r') do |rep|
  rep.each_line do |line|
    clone(line)
    lines_in_this_repository = 0
    i = 0
    begin
      directory = line.split('/').last
      origin_directory = directory
      directory = directory.gsub("\n",'')
      if(format == 'ruby')
        directory.insert(directory.size, '/**/*.rb')
        i = 3
      elsif (format == 'java')
        directory.insert(directory.size, '/**/*.java')
        i = 3
      elsif (format == 'c++')
        if i == 0
          directory.insert(directory.size, '/**/*.h')
          i += 1
        elsif i == 1
          directory.insert(directory.size, '/**/*.cc')
          i += 1
        elsif i == 2
          directory.insert(directory.size, '/**/*.cpp')
          i += 1
        end
      end
      Dir.glob(directory).each do |f|
        #if(count <= 100000)
        if(File.file?(f))
          puts 1
          `ruby script.rb #{f}`
          puts 2
          file = File.open(f, 'r')
          file.each_line do |row|
            count += 1
            lines_in_this_repository += 1
          end
          puts f
        #end
        end
      end
    end while i < 3
    CSV.open('repository.csv', 'a') do |csv|
      line = line.gsub("\n",'')
      csv << [line, lines_in_this_repository]
      sum = sum + lines_in_this_repository
    end
    delete_rep(origin_directory)
  end
  sort_csv 'first_sort.csv'
  join_repetitive
  sort_csv 'result.csv'
  delete_file 'first_sort.csv'
  make_json('result.csv',res_of_rep)
  remove_makrs 'result.csv'
  make_svg('SVG_result.csv',name_of_svg)
end
#puts "All rows in all repositories:"+sum
