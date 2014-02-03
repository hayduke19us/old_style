class Format
  attr_writer :found, :empty

  def initialize(args)
    @found = args[:found]
    @empty = args[:empty]
  end
end
