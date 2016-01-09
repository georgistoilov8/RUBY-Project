def draw_bar x,y,w,h
  '<rect x="'+x.to_s+'" y="'+y.to_s+'" width="'+w.to_s+'" height="'+h.to_s+'" fill = "cornflowerblue" style="stroke-width:2;stroke:rgb(0,0,0)"/>'
end
def add_text x, y, word
  '<text x="'+x.to_s+'" y="'+y.to_s+'" transform="rotate(0 '+x.to_s+' '+y.to_s+')" style="text-anchor:end;" fill="black">'+word.to_s+'</text>'
end
#constants
SYMBOL = 10
WIDTH_GRAPH = 50
height = 517
height_of_graph = 500
csv = ARGV[0]
csv = File.read csv
width = 60
max_size_of_text = 0
count = 0
keeper_of_digit = ""
checker = 1
less_word = 0
csv.each_line { |line|
  if checker != 0
    help = line.split(",")
    keeper_of_digit = help[1]
    checker = 0
  end
  less_word = line.split(",").last.to_i
  less_word = line.split(",").last.to_i if less_word > line.split(",").last.to_i
  size_of_word = line.split(",").first.size
  max_size_of_text = size_of_word if max_size_of_text < size_of_word
  count += 1
  width = width + 60
}
checker = 1
x = 10
y = 20
height = height + (max_size_of_text * 15 + 15)
File.open('svg_program.svg','w')  do |svg|
  svg.write('<svg xmlns="http://www.w3.org/2000/svg" width="'+width.to_s+'" height="'+height.to_s+'">')
  csv.each_line do |line|
      line = line.split(",")
      if keeper_of_digit == line[1]
        x = x + 55 if checker != 1
        checker = 0
      else
        height_of_graph = height_of_graph - height_of_graph/2
        x = x + 55
        y = 520 - height_of_graph
      end
      if line[1].tr("\n",'').to_i == less_word
        height_of_graph = 1
        y = 519
      end
      digit = 1
      number = 25
      marks = line[1]
      while marks.to_s.length > digit
        digit = digit + 1
        number = number + 5
      end
      svg.write(draw_bar x, y ,WIDTH_GRAPH,height_of_graph)
      svg.write(add_text x + number, y - 5, marks)
      mover = 0
      line[0].each_char do |chr|
        svg.write(add_text x + 26.5, 520 + 15 + mover, chr)
        mover = mover + 15
      end
      keeper_of_digit = line[1]
    end
    svg.write('</svg>')
end
#1 symbol => 7
