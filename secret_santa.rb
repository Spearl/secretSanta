#!/usr/bin/env ruby

PEOPLE = ['Landon', 'Katie', 'Iain', 'Liv', 'Sam', 'Kayla']
COUPLES = [['Landon', 'Katie'], ['Iain', 'Liv'], ['Sam', 'Kayla']]

def secretSanta(names, couples)
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
    peeps = possibilities[name].sample
    puts "#{name} => #{peeps}"
    puts
    names.each do |name|
      possibilities[name].delete(peeps)
    end
    santa_pairs[name] = peeps
  end
  return santa_pairs
end

pairs = secretSanta(PEOPLE, COUPLES)
pairs.each_pair do |k,v|
  puts "#{k} => #{v}"
end

pairs.each_pair do |k,v|
  if k == v
    raise "#{k} got themselves!"
  end
end

if pairs.values.uniq.length != PEOPLE.length
  raise "There are names missing!"
end

COUPLES.each do |couple|
  if pairs[couple[0]] == couple[1] || pairs[couple[1]] == couple[0]
    raise "Someone got their SO!"
  end
end
