NUM_DIMENSIONS = 10
NUM_ENTRIES    = 100000
SEARCH_RADIUS  = 0.8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'ffi-kdtree'))

begin
  num_dimensions = NUM_DIMENSIONS
  num_entries = NUM_ENTRIES
  search_radius = SEARCH_RADIUS

  puts "* Initializing tree with #{num_dimensions} dimensions"
  kdtree = KdTree::Tree.new(num_dimensions, :integer)

  puts "* Adding #{num_entries} entries to tree with random coordinates"
  1.upto(num_entries).each do |id| 
    kdtree.add(1.upto(num_dimensions).collect { rand * 2.0 - 1.0}, id)
  end

  pos = 1.upto(num_dimensions).collect { rand * 2.0 - 1.0 }
  puts "* Chose a random position at #{pos.join(',')}"

  puts "* Find its nearest neighbor"
  where, data = kdtree.find_nearest(pos)

  puts "* Found: #{data} at a distance of #{kdtree.distance(pos, where)} at #{where.join(',')}"

  neighbors = kdtree.find_nearest_range(pos, search_radius)
  puts "* Found #{neighbors.size} neighbors within radius #{search_radius}"
  neighbors.each do |neighbor|
    where, data = *neighbor
    puts "* Found neighbor: #{data}, distance of #{kdtree.distance(pos, where)}"
  end
end
