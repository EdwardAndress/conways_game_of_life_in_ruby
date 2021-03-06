# the world doesn't decide who lives or dies
# but it knows who is alive and who is dead
# and it can carry out the deeds of a higher power
# to kill and animate as required

require 'colorize'

class World

  DEAD_CELL = " "
  LIVE_CELL = "\u25A2".white
  HEIGHT = 50
  WIDTH = 100

  attr_reader :cells 

  def initialize(width: WIDTH, height: HEIGHT, seeds: [])
    @height = height
    @width = width
    @cells = create_cells
    add_seeds(seeds) if seeds.any?
  end

  def next_generation
    World.new(height: @height, width: @width)
  end

  def create_cells
    (1..@height).map do
      (1..@width).map do
        DEAD_CELL
      end
    end
  end

  def live_cells
    @cells.each_with_index.map do |row, row_index|
      row.each_with_index.map do |cell, col_index|
        [row_index, col_index] if alive?(cell)
      end.compact
    end.compact.flatten(1)
  end

  def dead_cells
    @cells.each_with_index.map do |row, row_index|
      row.each_with_index.map do |cell, col_index|
        [row_index, col_index] if dead?(cell)
      end.compact
    end.compact.flatten(1)
  end

  def neighbours_of(row, col)
    [
      [row - 1, col - 1],
      [row - 1, col],
      [row - 1, (col + 1) % @width],
      [row, col - 1],
      [row, (col + 1) % @width],
      [(row + 1) % @height, col - 1],
      [(row + 1) % @height, col],
      [(row + 1) % @height, (col + 1) % @width]
    ]
  end

  def live_neighbour_count(row, col)
    neighbours_of(row, col).each_with_object([]) do |coords, live_cell_coords|
      live_cell_coords << coords if alive_at?(coords)
    end.count
  end

  def animate_cell(row, col)
    @cells[row][col] = LIVE_CELL
  end

  def kill_cell(row, col)
    @cells[row][col] = DEAD_CELL
  end

  def add_seeds(seed_indices)
    seed_indices.each do |row, col|
      @cells[row][col] = LIVE_CELL
    end
  end

  def alive_at?(coords)
    cell = @cells[coords.first][coords.last]
    alive?(cell)
  end

  def alive?(cell)
    cell == LIVE_CELL
  end

  def dead?(cell)
    cell == DEAD_CELL
  end
end