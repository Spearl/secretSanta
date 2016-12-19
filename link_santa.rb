#!/usr/bin/env ruby

class Santa
  def initialize(name)
    @name = name
  end
  attr_reader :name
  attr_accessor :to_santa, :from_santa
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
    santa.from_santa = santas[i - 1]
  end
  current = head = santas[-1].to_santa = santas[0]

  while current.to_santa != head do
    if current.to_santa.name == couples_hash[current.name]
      # Remove current santa
      current.from_santa.to_santa = current.to_santa
      current.to_santa.from_santa = current.from_santa

      # Insert two spots down
      new_from_santa = current.to_santa.to_santa
      new_to_santa = new_from_santa.to_santa
      new_from_santa.to_santa = current
      new_to_santa.from_santa = current
      current.to_santa = new_to_santa
      current.from_santa = new_from_santa

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

