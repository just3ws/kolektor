# frozen_string_literal: true

class Customer
  attr_reader :id

  def initialize(id = 0)
    @id = id
  end
end
