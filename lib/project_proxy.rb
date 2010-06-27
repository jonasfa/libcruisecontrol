require 'delegate'

class ProjectProxy < DelegateClass(Hash)
  def initialize(hash = {})
    super(hash)
  end

  # Returns true if the current build of this project was successfull  
  def pass?
    self['description'] == 'Build passed'
  end
end
