class Image
  def initialize(input_rows)
    @image = input_rows
  end

  def output_image
    for row in @image do
      output_string = ""
      for pixel in row do
        output_string += ' ' unless output_string.length == 0
        output_string += pixel.to_s
      end
      puts output_string
    end
  end

  def blur(manhattan_distance)
    pixels_to_blur.each { |coordinates|
      pixels_within_manhattan_distance_of(manhattan_distance, coordinates.first, coordinates.last).each { |to_blur|
        # puts("Need to blur pixel at [#{to_blur.first}, #{to_blur.last}]")   # [x, y] coordinates
        @image[to_blur.first][to_blur.last] = 1   # because in the image, row/y is the first dimension
      }
    }
  end

  def pixels_to_blur
    retval = []
    @image.each.with_index { |row, y|
      row.each.with_index { |pixel, x|
        retval << [x, y] if pixel == 1
      }
    }
    retval
  end

  def out_of_bounds?(row_index, column_index)
    row_index < 0 || row_index >= @image.size || column_index < 0 || column_index >= @image[row_index].size
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