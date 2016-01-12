require_relative "../lib/my_enumerable"

class ArrayWrapper
  attr_accessor :list
  include MyEnumerable

  def initialize(*list)
    @list = list
  end

  def each
    list.each { |element| yield(element) }
  end
end

describe 'MyEnumerable' do
  before do
    @collection = ArrayWrapper.new(2, 1, 4, 6, 5)
  end

  describe '#map' do
    it 'returns a new array with the result of yielding each element to the block' do
      expect(@collection.map { |e| e + 1 }).to eq([3, 2, 5, 7, 6])
    end

    it '#returns an enumerator if a block is not provided' do
      expect(@collection.map).to be_instance_of(Enumerator)
    end
  end

  describe '#map!' do
    it 'replaces each element of self' do
      expect(@collection.map! { |e| e + 1 }).to equal(@collection)
    end

    it 'returns the result of yielding each element to the block' do
      expect(@collection.map { |e| e + 1 }).to eq([3, 2, 5, 7, 6])
    end

    it 'returns an enumerator if a block is not provided' do
      expect(@collection.map).to be_instance_of(Enumerator)
    end
  end

  describe '#select' do
    it 'returns an array containing all elements for which the given block returns a true value' do
      expect(@collection.select { |e| e.even? }).to eq([2, 4, 6])
    end

    it 'returns an enumerator if a block is not provided' do
      expect(@collection.map).to be_instance_of(Enumerator)
    end
  end

  describe '#include?' do
    it 'returns true if any element in the collection is equal to the object passed in ' do
      expect(@collection.include?(4)).to be_truthy
    end
  end

  describe '#first' do
    it 'returns the first element of the enumerator when an argument is not provided' do
      expect(@collection.first).to eq(2)
    end

    it 'returns the first n elements if the enumerator when an argument is provided' do
      expect(@collection.first(3)).to eq([2, 1, 4])
    end
  end

  describe '#count' do
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

  describe '#each_with_object' do
    it 'iterates the block for each element and returns the initially provided object' do
      expect(@collection.each_with_object([]) { |int, obj| obj << int*2 } ).to eq([4, 2, 8, 12, 10])
    end

    it 'returns an enumerator if a block is not provided' do
      expect(@collection.each_with_object([])).to be_instance_of(Enumerator)
    end
  end
end
