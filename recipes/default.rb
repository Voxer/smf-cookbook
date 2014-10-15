if node[:smf][:smfgen][:install] then
  include_recipe 'npm'
  npm_package "#{node[:smf][:smfgen][:name]}@#{node[:smf][:smfgen][:version]}"
end

directory node[:smf][:dirs][:manifest] do
  recursive true
end
