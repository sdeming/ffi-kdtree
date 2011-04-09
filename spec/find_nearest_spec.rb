require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe KdTree::Tree do
  include TestHelpers

  it "should find neighbors in a 2D tree" do
    tree = KdTree::Tree.new(2, :string)
    tree.add([-1,   -1  ], "top-left"         )
    tree.add([-0.5, -0.5], "mid-upper-left"   )
    tree.add([ 1,   -1  ], "top-right"        )
    tree.add([ 0.5, -0.5], "mid-upper-right"  )
    tree.add([ 0,    0  ], "center"           )
    tree.add([-0.5,  0.5], "mid-lower-left"   )
    tree.add([-1,    1  ], "bottom-left"      )
    tree.add([ 0.5,  0.5], "mid-lower-right"  )
    tree.add([ 1,    1  ], "bottom-right"     )

    where, data = tree.find_nearest([0, 0])
    where.should == [0, 0]
    data.should == "center"

    where, data = tree.find_nearest([0.3, 0.3])
    where.should == [0.5, 0.5]
    data.should == "mid-lower-right"

    where, data = tree.find_nearest([-0.3, -0.3])
    where.should == [-0.5, -0.5]
    data.should == "mid-upper-left"

    where, data = tree.find_nearest([0.1,0.1])
    where.should == [0, 0]
    data.should == "center"

    locations = tree.find_nearest_range([0, 0], 2)
    locations.size.should == 9 # all of them

    locations = tree.find_nearest_range([0, 0], 1)
    locations.size.should == 5 # center + mids
  end
end
