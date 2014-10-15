# Directory to store XML manifest files
default[:smf][:dirs][:manifest] = '/opt/local/share/smf/manifest/chef'

# whether to install `smfgen` globally
default[:smf][:smfgen][:install] = true

# `smfgen` version specifics
default[:smf][:smfgen][:name] = 'smfgen'
default[:smf][:smfgen][:version] = '0.1.2'
