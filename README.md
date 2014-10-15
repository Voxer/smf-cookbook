Description
===========

Simple, single dependency, SMF LWRP

Requirements
============

1. An [Illumos](http://illumos.org) based Operating System
2. The [npm](https://github.com/Voxer/npm-cookbook) cookbook
3. Node.js installed

This module automatically installs https://github.com/davepacheco/smfgen
to convert JSON => XML for SMF if `node[:smf][:smfgen][:install]` is `true`

Attributes
==========

``` ruby
# Directory to store XML manifest files
default[:smf][:dirs][:manifest] = '/opt/local/share/smf/manifest/chef'

# whether to install `smfgen` globally
default[:smf][:smfgen][:install] = true

# `smfgen` version specifics
default[:smf][:smfgen][:name] = 'smfgen'
default[:smf][:smfgen][:version] = '0.1.2'
```

Usage
=====

``` ruby
include_recipe 'smf'

# Create a basic service
# this will create the SMF XML manifest file, and import it automatically
smf_service 'daves-basic-service' do    # will become svc:/application/daves-basic-service:default
  label 'Daves Basic Service'           # human readable name
  start '/opt/local/bin/some-daemon'    # start script to run, an '&' is appended automatically to background the processes
end

# Create an advanced service
# this will create the SMF XML manifest file, and import it automatically
smf_service 'daves-advanced-service' do # will become svc:/network/daves-advanced-service:default
  label 'Daves Advanced Service'        # human readable name
  start '/var/foo/bar.sh'               # start script to run, an '&' is appended automatically to background the processes
  category 'network'                    # [optional] service category, defaults to 'application'
  cwd '/var/tmp'                        # [optional] processes CWD
  user 'nobody'                         # [optional] user to start the service as
  group 'other'                         # [optional] group to start the service as
  dependencies []                       # [optional] array of service FMRIs that must be online before this service is started
  env ({                                # [optional] environmental variables
    :PATH => '/opt/local/bin:/opt/local/sbin'
  })
end

# Remove the service
smf_service 'daves-test-service' do
  action :remove                    # will issue `svccfg delete daves-test-service` if
                                    # `svcs daves-test-service` returns 0 (the service is found)
                                    # NOTE this will fail if the service is running
end
```

License
=======

MIT License

```
Copyright: 2007-2014, Voxer, Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
