# -*- encoding: utf-8 -*-
# stub: reel 0.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "reel".freeze
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tony Arcieri".freeze]
  s.date = "2016-03-15"
  s.description = "A Celluloid::IO-powered HTTP server".freeze
  s.email = ["tony.arcieri@gmail.com".freeze]
  s.homepage = "https://github.com/celluloid/reel".freeze
  s.rubygems_version = "3.3.7".freeze
  s.summary = "A Reel good HTTP server".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<celluloid>.freeze, [">= 0.15.1"])
    s.add_runtime_dependency(%q<celluloid-io>.freeze, [">= 0.15.0"])
    s.add_runtime_dependency(%q<http>.freeze, [">= 0.6.0.pre"])
    s.add_runtime_dependency(%q<http_parser.rb>.freeze, [">= 0.6.0"])
    s.add_runtime_dependency(%q<websocket-driver>.freeze, [">= 0.5.1"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 2.11.0"])
    s.add_development_dependency(%q<certificate_authority>.freeze, [">= 0"])
    s.add_development_dependency(%q<websocket_parser>.freeze, [">= 0.1.6"])
  else
    s.add_dependency(%q<celluloid>.freeze, [">= 0.15.1"])
    s.add_dependency(%q<celluloid-io>.freeze, [">= 0.15.0"])
    s.add_dependency(%q<http>.freeze, [">= 0.6.0.pre"])
    s.add_dependency(%q<http_parser.rb>.freeze, [">= 0.6.0"])
    s.add_dependency(%q<websocket-driver>.freeze, [">= 0.5.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.11.0"])
    s.add_dependency(%q<certificate_authority>.freeze, [">= 0"])
    s.add_dependency(%q<websocket_parser>.freeze, [">= 0.1.6"])
  end
end
