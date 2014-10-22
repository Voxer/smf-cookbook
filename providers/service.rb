include Chef::Mixin::ShellOut

use_inline_resources

action :create do
  h = new_resource.to_hash

  # clean up
  h.delete(:source_line)

  # make keys suitable for `smfgen`
  h[:ident] ||= h[:name]
  h[:start] = {
    :exec => h[:start]
  }

  if h[:refresh] then
    h[:refresh] = {
      :exec => h[:refresh]
    }
  end

  h[:start][:working_directory] = h[:cwd]          if h[:cwd]        ; h.delete(:cwd)
  h[:start][:user]              = h[:user]         if h[:user]       ; h.delete(:user)
  h[:start][:group]             = h[:group]        if h[:group]      ; h.delete(:group)
  h[:start][:environment]       = h[:env]          if h[:env]        ; h.delete(:env)
  h[:start][:privileges]        = h[:privileges]   if h[:privileges] ; h.delete(:privileges)

  svc = "#{new_resource.category}/#{new_resource.name}"

  # XML specifics
  xml_file = ::File.join(node[:smf][:dirs][:manifest], "#{svc}.xml")
  xml_dir = ::File.dirname(xml_file)

  # ensure the xml directory exists
  directory "#{svc} XML directory" do
    path xml_dir
    recursive true
  end

  # import the XML
  execute "Import SMF Manifest for #{svc}" do
    command ['svccfg', 'import', xml_file]
    action :nothing
  end

  # Create the manifest
  file xml_file do
    content lazy { shell_out!([node[:smf][:smfgen][:name]], :input => JSON.dump(h)).stdout }
    notifies :run, "execute[Import SMF Manifest for #{svc}]", :immediately
  end
end

action :remove do
  svc = new_resource.name
  execute "Remove SMF Service #{svc}" do
    command ['svccfg', 'delete', svc]
    only_if { shell_out(['svcs', svc]).exitstatus == 0 }
  end
end
