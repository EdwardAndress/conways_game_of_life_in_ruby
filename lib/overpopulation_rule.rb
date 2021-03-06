require_relative './rule'

class OverpopulationRule < Rule
  def apply
    @world.live_cells.each do |row, col|
      @next_gen.kill_cell(row, col) if @world.live_neighbour_count(row, col) > 3
    end
  end
end