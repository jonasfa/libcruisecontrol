require 'active_support'
require 'project_proxy'

class CruiseControlServer
  attr_reader :projects
  
  def initialize(host, port)
    @projects = []
    refresh
  end
  
  # Retrieve the projects' newest status from the server 
  def refresh
    @projects.replace parse_projects_from_xml(Net::HTTP.get 'localhost:8990', '/dashboard/rss.xml')
  end
  
  # Returns true if all projects from this server passes
  def pass?
    projects.all? {|p| p.pass?}
  end
  
  private
  
  def parse_projects_from_xml(xml)
    @projects = Hash.from_xml(xml)['rss']['channel']['item']
    @projects = [@projects] unless @project.class == Array
    @projects.map!{|p| ProjectProxy.new p}
  end
end
