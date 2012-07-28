# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_commentable_with_replies/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Filvo Interactive"]
  gem.email         = ["info@filvo.com"]
  gem.description   = %q{Acts as Commentable with Replies}
  gem.summary       = %q{A threaded comment system for Rails}
  gem.homepage      = "http://www.filvo.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "acts_as_commentable_with_replies"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsCommentableWithReplies::VERSION

  gem.add_development_dependency 'rails', '~> 3.0'

  gem.add_dependency 'awesome_nested_set', '>= 2.0'
end
