set :deploy_to, '/home/apps/myapp'
set :rails_env, 'production'
set :branch, ENV["BR"] || 'master'
set :ssh_options, {
  user: 'apps'
}
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.


require "aws-sdk-v1"
require "aws-sdk"
aws_conf = YAML.load(IO.read("./config/application.yml"))["development"]["aws"].symbolize_keys
AWS.config(aws_conf)
lb_name = "lb.5fpro.com"
servers = AWS::ELB.new.load_balancers[lb_name].instances.map(&:ip_address)

shadow_server = "myapp.5fpro.com"
role :app,             servers + [ shadow_server ]
role :web,             servers + [ shadow_server ]
role :db,              shadow_server
role :whenever_server, shadow_server
role :sidekiq_server,  shadow_server


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
