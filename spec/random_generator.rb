module RandomGenerator

  def RandomGenerator.bool
    [true, false].sample
  end

  def RandomGenerator.country
    %w(US CZ AU DE).sample
  end

end
