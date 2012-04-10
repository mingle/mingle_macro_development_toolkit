require File.join(File.dirname(__FILE__), 'unit_test_helper')

class <%= macro_class_name %>Test < Test::Unit::TestCase

  PROJECT = 'scrum_template_2_1'

  def test_macro_contents
    <%= macro_name %> = <%= macro_class_name %>.new(nil, project(PROJECT), nil)
    result = <%= macro_name %>.execute
    assert result
  end

  def test_macro_contents_with_a_project_group
    <%= macro_name %> = <%= macro_class_name %>.new(nil, [project(PROJECT), project(PROJECT)], nil)
    result = <%= macro_name %>.execute
    assert result
  end

end
