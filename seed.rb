require 'active_record'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/research_field'
require_relative 'models/publication'
require_relative 'models/comment'

ResearchField.create name: 'Computer Science'
ResearchField.create name: 'Microbiology'
ResearchField.create name: 'Pharmacy'