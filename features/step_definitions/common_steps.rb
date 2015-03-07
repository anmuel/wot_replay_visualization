Given(/^I open the "(\w+)" page of the "(.+)" resource$/) do |action, resource_name|
  path = path_for_resource_with_action(resource_name, action)
  visit path
  expect(current_path).to eq path
  expect(last_response).to be_successful
end

Then(/^I should be redirected to the "(.+)" page of the "(.+)" resource$/) do |action, resource_name|
  expect(current_path).to eq path_for_resource_with_action(resource_name, action)
  expect(last_response.status).to be_in(300..399)
end

Then(/^I should see a success message$/) do
  expect(find('.success')).to be
end

def path_for_resource_with_action(resource_name, action_name)
  resource_path = resource_name.parameterize('_').pluralize
  action_slug = case action_name
    when 'index' then ''
    else "/#{action_name}"
  end
  "/#{resource_path}#{action_slug}"
end
