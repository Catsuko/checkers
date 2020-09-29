RSpec::Matchers.define(:be_above) do |origin|
  match do |position|
    position.above?(origin)
  end
  failure_message do |position|
    "Expected that #{position} was above #{origin}"
  end
end

RSpec::Matchers.define(:be_below) do |origin|
  match do |position|
    position.below?(origin)
  end
  failure_message do |position|
    "Expected that #{position} was below #{origin}"
  end
end

RSpec::Matchers.define(:be_left_of) do |origin|
  match do |position|
    position.left_of?(origin)
  end
  failure_message do |position|
    "Expected that #{position} was left of #{origin}"
  end
end

RSpec::Matchers.define(:be_right_of) do |origin|
  match do |position|
    position.right_of?(origin)
  end
  failure_message do |position|
    "Expected that #{position} was right of #{origin}"
  end
end