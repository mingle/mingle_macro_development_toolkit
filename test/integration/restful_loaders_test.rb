#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.

require File.join(File.dirname(__FILE__), 'integration_test_helper')

class RestLoaderTest < Test::Unit::TestCase
  
  TEST_PROJECT = 'http://bjanakir:pass1.@localhost:8080/api/v2/lightweight_projects/macro_toolkit_test.xml'
  TEST_PROJECT_V1 = "http://bjanakir:pass1.@localhost:8080/api/v1/lightweight_projects/macro_toolkit_test.xml"
  
  def test_should_load_direct_project_attributes_from_correct_fixture
    assert_not_nil project(TEST_PROJECT)
    assert_equal 'macro_toolkit_test', project(TEST_PROJECT).identifier
  end
  
  def test_should_load_first_level_project_associations_from_correct_fixture
    assert_equal(["Story", "Release", "Sprint", "Task", "Defect", "Feature", "Epic Story"], project(TEST_PROJECT).card_types.collect(&:name))
  end

  def test_should_load_second_level_project_associations_for_card_type_from_correct_fixture
    task_type = project(TEST_PROJECT).card_types.detect { |ct| ct.name == 'Task' }
    assert_equal(["Priority", "Task Status", "Owner", "Depend on", "Release", "Sprint", "Story", "Date Task Completed", "Estimated Hours"], task_type.property_definitions.collect(&:name))
  end

  def test_should_load_second_level_project_associations_for_property_definition_from_correct_fixture
    priority_definition = project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Priority' }
    assert_equal(['Story', 'Task', 'Defect'], priority_definition.card_types.collect(&:name))
  end
  
  def test_should_load_correct_values_for_property_definitions
    priority_definition = project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Priority' }
    assert_equal ['Low', 'Medium', 'High'], priority_definition.values.collect(&:db_identifier)
  end
  
  def test_should_load_predefined_property_definitions
    assert project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Name' }
    assert project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Number' }
  end

  def test_should_load_correct_colors_for_values_of_property_definitions
    priority_definition = project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Priority' }
    assert_equal ['f1ff26', 'ff6600', 'b30600'], priority_definition.values.collect(&:color)
  end  

  def test_should_load_correct_team_members
    assert_equal [], project(TEST_PROJECT).team.collect(&:login)
  end  
  
  def test_should_detect_project_variables
    assert_equal '#21 Release 1', project(TEST_PROJECT).value_of_project_variable('Current Release')
  end  

  def test_should_execute_mql_to_return_an_array_of_hash_results_for_each_result_row_for_v2
    mql_results = project(TEST_PROJECT).execute_mql("SELECT SUM('Story Points') WHERE 'Release' = (Current Release) AND 'Date Created' IS NOT NULL")
    assert_equal 1, mql_results.size
    assert_equal Hash, mql_results.first.class
    assert_equal 97, mql_results.first['sum_story_points'].to_i
  end  

  def test_should_execute_mql_to_return_an_array_of_hash_results_for_each_result_row_for_v1
    mql_results = project(TEST_PROJECT_V1).execute_mql("SELECT SUM('story points') WHERE 'Release' = (Current Release) AND 'Date Created' IS NOT NULL")
    assert_equal 1, mql_results.size
    assert_equal Hash, mql_results.first.class
    assert_equal 97, mql_results.first['Sum_Story_Points'].to_i
  end  

  def test_should_execute_number_format_remotely_for_v2
    proj = project(TEST_PROJECT)
    assert_equal "3.67", proj.format_number_with_project_precision("3.6711").to_s
    assert_equal "20.14", proj.format_number_with_project_precision("20.1398").to_s
  end  

  def test_should_execute_number_format_remotely_for_v1
    proj = project(TEST_PROJECT_V1)
    assert_equal "3.67", proj.format_number_with_project_precision("3.6711").to_s
    assert_equal "20.14", proj.format_number_with_project_precision("20.1398").to_s
  end  

  def test_should_execute_date_format_remotely_for_v2
    proj = project(TEST_PROJECT)
    assert_equal "22 May 2005", proj.format_date_with_project_date_format(Date.new(2005, 5, 22))
    assert_equal "06 Oct 2008", proj.format_date_with_project_date_format(Date.new(2008, 10, 6))
  end  

  def test_should_execute_date_format_remotely_for_v1
    proj = project(TEST_PROJECT_V1)
    assert_equal "22 May 2005", proj.format_date_with_project_date_format(Date.new(2005, 5, 22))
    assert_equal "06 Oct 2008", proj.format_date_with_project_date_format(Date.new(2008, 10, 6))
  end  

  def test_should_errors_in_executing_mql_should_be_available_in_the_test
    project = project(TEST_PROJECT)
    mql_results = project.execute_mql("SELECT 'Invalid Property Name'")
    assert_equal 1, errors.size
    assert_equal "Card property 'Invalid Property Name' does not exist!", errors.first
  end  
  
  def test_should_raise_error_on_trying_to_call_values_for_anything_other_than_managed_or_user_properties
    added_on = project(TEST_PROJECT).property_definitions.detect { |pd| pd.name == 'Date Created' }
    assert_raise(RuntimeError) { added_on.values }
  end  
  
  def test_should_tell_whether_mql_query_is_cacheable
    assert project(TEST_PROJECT).can_be_cached?("SELECT 'Story Points'")
    assert_equal false, project(TEST_PROJECT).can_be_cached?("SELECT 'Story Points' WHERE 'Date Created' IS TODAY")
  end
  
end