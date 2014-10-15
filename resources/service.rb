actions :create, :remove
default_action :create

attribute :name, :name_attribute => true

attribute :category, :kind_of => String, :default => 'application'
attribute :cwd, :kind_of => String, :default => '/'
attribute :dependencies, :kind_of => Array
attribute :env, :kind_of => Hash
attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :ident, :kind_of => String
attribute :label, :kind_of => String
attribute :privileges, :kind_of => Array
attribute :start, :kind_of => [String, Hash]
attribute :stop, :kind_of => [String, Hash]
attribute :refresh, :kind_of => [String, Hash]
attribute :user, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
