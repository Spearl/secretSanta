#!/usr/bin/env ruby

def _secretSanta(names, couples)
  # Enter code here
  santa_pairs = {}
  couples_hash = {}
  possibilities = {}

  # Creates SO lookup
  couples.each do |couple|
    couples_hash[couple.first] = couple.last
    couples_hash[couple.last] = couple.first
  end

  # Create possibilities lookup
  names.each do |name|
    possibilities[name] = names.select { |n| n != name && n != couples_hash[name] }
  end

  names.each do |name|
    match = possibilities[name].sample
    #puts "#{name} => #{match}"
    #puts
    names.each do |name|
      possibilities[name].delete(match)
    end
    santa_pairs[name] = match
  end

  santa_pairs.each_pair do |k,v|
    if k == v
      raise "#{k} got themselves!"
    end
  end

# Added .compact, because that removes "nil" as a value
  if santa_pairs.values.uniq.compact.length != names.length
    raise "There are names missing!"
  end

  couples.each do |couple|
    if santa_pairs[couple[0]] == couple[1] || santa_pairs[couple[1]] == couple[0]
      raise "Someone got their SO!"
    end
  end
  return santa_pairs
end

def secretSanta(names, couples)
  begin
    return secretSanta(names, couples)
  rescue
    retry
  end
end
