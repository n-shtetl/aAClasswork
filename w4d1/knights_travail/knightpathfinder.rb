class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    if nil == new_parent
       self.parent.children.delete(self)
       @parent = nil
    else
      return nil if new_parent.children.include?(self)
      self.parent.children.delete(self) unless self.parent == nil
      @parent = new_parent
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
  end

  def dfs(target) 
    return self if @value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty? 
      current = queue.shift
      return current if current.value == target_value
      queue += current.children
    end
    nil
  end
end

class KnightPathFinder
  attr_accessor :root_node, :considered_positions
  def initialize(starting_pos)
    self.root_node = PolyTreeNode.new(starting_pos)
    # self.root_node.children = self.build_move_tree
    @considered_positions = [starting_pos]
  end
  MOVES = [[1,2], [1,-2], [-1,2], [-1,-2],
             [2,1], [2,-1], [-2,1], [-2,-1]]
  def self.valid_moves(pos)
    #[x,y]
    possible_moves = MOVES.map do |move|
      [pos[0] + move[0], pos[1] + move[1]]
    end
    possible_moves.select {|move| (0..7).include?(move[0]) && (0..7).include?(move[1])}
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).select do |move| 
      !@considered_positions.include?(move)
    end

    @considered_positions += new_moves
    new_moves
  end

  # def build_move_tree(end_position)
  #   # queue = [self.root_node.value]
  #   # until queue.empty?
  #   #   current = queue.shift
  #   #   return current if current == end_position
  #   #   queue += new_move_positions(current)
  #   # end

  # end

  def build_move_tree
    queue = [self.root_node]
    until queue.empty?
      current = queue.shift
      new_move_positions(current.value).each do |move|
        current.add_child(PolyTreeNode.new(move))
      end
      queue += current.children
    end
    self.root_node
  end

  def find_path(end_pos)
    self.build_move_tree
    end_node = self.root_node.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(node)
    path = [node.value]
    #start from ending node and return to starting position
    until node.parent.nil?
      path << node.parent.value
      node = node.parent
    end
    path.reverse
  end


end