require_relative "../lib/my_enumerable"

class ArrayWrapper
  attr_accessor :list
  include MyEnumerable

  def initialize
    @list = []
  end

  def each
    list.each { |element| yield(element) }
  end

  def <<(new_element)
    list << new_element
  end
end

describe 'MyEnumerable' do
  before do
    @collection = ArrayWrapper.new
    @collection << 2 << 1 << 4 << 6 << 5
  end

  context 'map' do
    it 'returns a new array with the results of yielding each element to the block' do
      expect(@collection.map { |e| e + 1 }).to eq([3, 2, 5, 7, 6])
    end

    it 'returns an enumerator if a block is not provided' do
      expect(@collection.map).to be_instance_of(Enumerator)
    end
  end

  context 'select' do
    it 'returns an array containing all elements for which the given block returns a true value' do
      expect(@collection.select { |e| e.even? }).to eq([2, 4, 6])
    end

    it 'returns an enumerator if a block is not provided' do
      expect(@collection.map).to be_instance_of(Enumerator)
    end
  end

  context 'include?' do
    it 'returns true if any element in the collection is equal to the object passed in ' do
      expect(@collection.include?(4)).to be_truthy
    end
  end

  context 'first' do
    it 'returns the first element of the enumerator when an argument is not provided' do
      expect(@collection.first).to eq(2)
    end

    it 'returns the first n elements if the enumerator when an argument is provided' do
      expect(@collection.first(3)).to eq([2, 1, 4])
    end
  end

  context 'count' do
    it 'returns the number of elements in the list when no arguments are provided' do
      expect(@collection.count).to eq(5)
    end

    it 'returns the number of elements in the list that are equal to the argument' do
      expect(@collection.count(6)).to eq(1)
    end

    it 'returns the number of elements that yield a true value' do
      expect(@collection.count { |e| e.even? }).to eq(3)
    end
  end
end
