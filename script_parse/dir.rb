require 'csv'

def clone rep
  `git clone #{rep}`
end

def delete_rep rep
  `rm -rf #{rep}`
end

def delete_file file_name
  `rm #{file_name}`
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

delete_file 'repository.csv'

count = 0
File.open('rep.txt', 'r') do |rep|
  rep.each_line do |line|
    clone(line)
    directory = line.split('/').last
    origin_directory = directory
    directory = directory.gsub("\n",'')
    if(format == 'ruby')
      directory.insert(directory.size, '/**/*.rb')
    elsif (format == 'java')
      directory.insert(directory.size, '/**/*.java')
    elsif (format == 'c++')
      directory.insert(directory.size, '/**/*.cc')
    else
      raise NoMethodError, "invalid \'#{format}\' format."
    end
    lines_in_this_repository = 0
    Dir.glob(directory).each do |f|
      if(count <= 100000)
        puts 1
        `ruby script.rb #{f}`
        puts 2
        file = File.open(f, 'r')
        file.each_line do |row|
          count += 1
          lines_in_this_repository += 1
        end
        puts f
      end
    end
    CSV.open('repository.csv', 'a') do |csv|
      line = line.gsub("\n",'')
      csv << [line, lines_in_this_repository]
    end
    delete_rep(origin_directory)
  end
  sort_csv 'first_sort.csv'
  join_repetitive
  sort_csv 'result.csv'
  delete_file 'first_sort.csv'
end
