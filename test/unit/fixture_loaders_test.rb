#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.

require File.join(File.dirname(__FILE__), 'unit_test_helper')

class FixtureLoaderTest < Test::Unit::TestCase
  
  PROJECT = 'scrum_template_2_1'
  
  def test_should_load_direct_project_attributes_from_correct_fixture
    assert_not_nil project(PROJECT)
    assert_equal 'scrum_template_2_1', project(PROJECT).identifier
  end
  
  def test_should_load_first_level_project_associations_from_correct_fixture
    assert_equal(['Release', 'Sprint', 'Story', 'Task', 'Defect', 'Feature', 'Epic Story'], project(PROJECT).card_types.collect(&:name))
  end
  
  def test_should_load_second_level_project_associations_for_card_type_from_correct_fixture
    task_type = project(PROJECT).card_types.detect { |ct| ct.name == 'Task' }
    assert_equal(['Estimate - Planning', 'Risk', 'Added On', 'Priority', 'Owner',  'Task Estimate'], task_type.property_definitions.collect(&:name))
  end
  
  def test_should_load_second_level_project_associations_for_property_definition_from_correct_fixture
    priority_definition = project(PROJECT).property_definitions.detect { |pd| pd.name == 'Priority' }
    assert_equal(['Story', 'Task', 'Defect'], priority_definition.card_types.collect(&:name))
  end
  
  def test_should_load_correct_values_for_property_definitions
    priority_definition = project(PROJECT).property_definitions.detect { |pd| pd.name == 'Priority' }
    assert_equal ['High', 'Medium', 'Low'], priority_definition.values.collect(&:db_identifier)
  end  
  
  def test_should_load_correct_team_members
    assert_equal ['groucho', 'harpo', 'karl'], project(PROJECT).team.collect(&:login)
  end  
  
  def test_should_detect_project_variables
    assert_equal 'Release 3', project(PROJECT).value_of_project_variable('Current Release')
  end  
  
  def test_should_raise_error_on_trying_to_call_values_for_anything_other_than_managed_or_user_properties
    added_on = project(PROJECT).property_definitions.detect { |pd| pd.name == 'Added On' }
    assert_raise(RuntimeError) { added_on.values }
  end  
end  

