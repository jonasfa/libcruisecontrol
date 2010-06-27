require 'cruise_control/project_proxy'

describe CruiseControl::ProjectProxy, '#pass?' do
  it 'should return true if description is "Build passed"' do
    CruiseControl::ProjectProxy.new({'description' => 'Build passed'}).pass?.should be true
  end
  
  it 'should return false if description is not "Build passed"' do
    CruiseControl::ProjectProxy.new({'description' => 'Build failed'}).pass?.should be false
  end
end
