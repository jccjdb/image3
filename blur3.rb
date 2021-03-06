class Image
  attr_accessor :image

  def initialize(image)
    @image = image
  end

  def find_ones
    pixels_to_blur = []
    @image.each_with_index do |row, row_index|
      row.each_with_index do |pixel, column_index|
        if pixel == 1
          pixels_to_blur << [row_index, column_index]
        end
      end
    end
    pixels_to_blur
  end

  def blur_ib2(distance)
    pixels_to_blur = find_ones
    @image.each_with_index do |row, row_index|
      row.each_with_index do |pixel, column_index|
        pixels_to_blur.each do |row_location, column_location|

          if row_index == row_location && column_index == column_location
            @image[row_index -1][column_index] = 1 unless row_index == 0 #above
            @image[row_index +1][column_index] = 1 unless row_index >= @image.size - 1 #below
            @image[row_index][column_index -1] = 1 unless column_index == 0 #to left
            @image[row_index][column_index +1] = 1 unless column_index >= row.size - 1 #to right
          end
        end
      end
    end
  end

  def blur(distance)
    pixels_to_blur = find_ones
    @image.each_with_index do |row, row_index|
      row.each_with_index do |pixel, column_index|
        pixels_to_blur.each do |row_location, column_location|
          pixels_to_change = pixels_within_manhattan_distance_of(distance, row_location, column_location)
          pixels_to_change.each do |coordinates|
            x = coordinates.first
            y = coordinates.last
            @image[y][x] = 1
          end
        end
      end
    end
  end

  def output_image
    @image.each do |row|
      puts row.join(", ")
    end
  end

  # Args: manhattan distance with central row and column indices
  # Returns an array of [x, y] indices within the specified distance of the central pixel
  def pixels_within_manhattan_distance_of(n, row_index, column_index)
    retval = []
    (1..n).each { |d|   # where d represents a row or column offset from the central pixel
      (0..d).each { |o|   # where o represents a row or column offset from d
        # pixels directly above and/or to the left
        y = row_index - (d - o)
        x = column_index - o
        retval << [x, y] unless out_of_bounds?(x, y)

        # pixels directly above and/or to the right
        x = column_index + o
        retval << [x, y] unless out_of_bounds?(x, y)

        # pixels directly below and/or to the left
        y = row_index + (d - o)
        x = column_index - o
        retval << [x, y] unless out_of_bounds?(x, y)

        # pixels directly above and/or to the right
        x = column_index + o
        retval << [x, y] unless out_of_bounds?(x, y)
      }
    }
    retval
  end

  def out_of_bounds?(row_index, column_index)
    row_index < 0 || row_index >= @image.size || column_index < 0 || column_index >= @image[row_index].size
  end

end

image = Image.new([
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 1],
  [0, 0, 0, 0]
])
image.output_image
image.blur(1)

puts("-------------")
image.output_image
puts("==========================  ")

image = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
])

image.output_image
image.blur(2)
puts("-------------")
image.output_image
puts("==========================  ")

image = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
])

image.output_image
image.blur(4)
puts("-------------")
image.output_image