require 'cruise_control_server'
require 'spec_helper'

XML1 = <<XML
<rss version="2.0"> 
<channel> 
  <title>CruiseControl Results</title> 
  <link>http://localhost:8080/dashboard/</link> 
  <description>Summary of the project build results.</description> 
  <language>en-us</language> 
  <item> 
    <title>connectfour passed Sat, 26 Jun 2010 18:07:28 -0300</title> 
    <description>Build passed</description> 
    <pubDate>Sat, 26 Jun 2010 18:07:28 -0300</pubDate> 
    <link>http://localhost:8080/dashboard/tab/build/detail/connectfour</link> 
  </item> 
 
</channel> 
</rss> 
XML

XML2 = <<XML
<rss version="2.0"> 
<channel> 
  <title>CruiseControl Results</title> 
  <link>http://localhost:8080/dashboard/</link> 
  <description>Summary of the project build results.</description> 
  <language>en-us</language> 
  <item> 
    <title>connectfour passed Sat, 26 Jun 2010 20:07:28 -0300</title> 
    <description>Build passed</description> 
    <pubDate>Sat, 26 Jun 2010 20:07:28 -0300</pubDate> 
    <link>http://localhost:8080/dashboard/tab/build/detail/connectfour</link> 
  </item> 
 
</channel> 
</rss> 
XML

describe CruiseControlServer, '#new' do
  it "should request the project list to the server" do
    stub_request(:any, "localhost:8990/dashboard/rss.xml").to_return :body => XML1
    cc = CruiseControlServer.new 'localhost', 8990
    cc.projects.should == [{"title" => "connectfour passed Sat, 26 Jun 2010 18:07:28 -0300", "description"=> "Build passed", "pubDate" => "Sat, 26 Jun 2010 18:07:28 -0300", "link" => "http://localhost:8080/dashboard/tab/build/detail/connectfour"}]
  end
end

describe CruiseControlServer, '#refresh' do
  it "should retrieve the newest values" do
    stub_request(:any, "localhost:8990/dashboard/rss.xml").to_return :body => XML1
    cc = CruiseControlServer.new 'localhost', 8990
    stub_request(:any, "localhost:8990/dashboard/rss.xml").to_return :body => XML2
    cc.refresh
    cc.projects.should == [{"title" => "connectfour passed Sat, 26 Jun 2010 20:07:28 -0300", "description"=> "Build passed", "pubDate" => "Sat, 26 Jun 2010 20:07:28 -0300", "link" => "http://localhost:8080/dashboard/tab/build/detail/connectfour"}]
  end
end

describe CruiseControlServer, '#pass?' do
  it 'should return true if all projects passes' do
    stub_request(:any, "localhost:8990/dashboard/rss.xml").to_return :body => XML1
    cc = CruiseControlServer.new 'localhost', 8990
    cc.pass?.should be true
  end
end
