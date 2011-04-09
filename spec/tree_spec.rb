require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe KdTree::Tree do
  include TestHelpers

  it "should create a 2D tree with 1000 random entries" do
    tree = generate_tree(2, 1000, :integer) do
      rand
    end
    tree.should_not be_nil
  end
end
