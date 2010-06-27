require 'active_support'
require 'cruise_control/project_proxy'

module CruiseControl
  class Server
    attr_reader :projects
    
    def initialize(host, port = 80)
      @host, @port = host, port
      @projects = []
      refresh
    end
    
    # Retrieve the projects' newest status from the server 
    def refresh
      @projects.replace parse_projects_from_xml(Net::HTTP.get @host, '/dashboard/rss.xml', @port)
    end
    
    # Returns true if all projects from this server passes
    def pass?
      projects.all? {|p| p.pass?}
    end
    
    private
    
    def parse_projects_from_xml(xml)
      @projects = Hash.from_xml(xml)['rss']['channel']['item']
      @projects = [@projects] unless @projects.class == Array
      @projects.map!{|p| ProjectProxy.new p}
    end
  end
end
