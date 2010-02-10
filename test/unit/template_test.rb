require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Template.new.valid?
  end
end
