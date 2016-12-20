#!/usr/bin/env ruby

class Santa
  def initialize(name)
    @name = name
  end
  attr_reader :name
  attr_accessor :to_santa
end

def secretSanta(names, couples)
  # Create SO lookup
  so_lookup = Hash[couples].merge(Hash[couples].invert)

  # Randomize name order
  names.shuffle!

  # Create linked list of santas
  santas = names.map { |name| Santa.new(name) }
  santas.each_with_index do |santa, i|
    santa.to_santa = santas[i + 1]
  end
  current = head = santas[-1].to_santa = santas[0]

  while current.to_santa != head do
    if current.to_santa.name == so_lookup[current.name]
      # Insert next santa one spot down
      moving_santa = current.to_santa
      current.to_santa = moving_santa.to_santa
      moving_santa.to_santa = moving_santa.to_santa.to_santa
      current.to_santa.to_santa = moving_santa

      # Start over
      current = head
    else
      current = current.to_santa
    end
  end

  santas.each_with_object({}) do |santa, santa_hash|
    santa_hash[santa.name] = santa.to_santa.name
  end
end

