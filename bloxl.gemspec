require './lib/bloxl/version'

Gem::Specification.new do |s|
  s.name     = 'bloxl'
  s.version  = BloXL::VERSION
  s.authors  = ['Victor Shepelev']
  s.email    = 'zverok.offline@gmail.com'
  s.homepage = 'https://github.com/zverok/bloxl'

  s.summary = 'Hi-level XLSX reporing DSL'
  # WRITEME!
  #s.description = <<-EOF
  #EOF
  s.licenses = ['MIT']

  s.files = `git ls-files`.split($RS).reject do |file|
    file =~ /^(?:
    spec\/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.travis.yml
    )$/x
  end
  s.require_paths = ["lib"]

  s.add_dependency 'axlsx'

  #s.add_development_dependency 'rubocop', '~> 0.30'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rspec-its', '~> 1'
  #s.add_development_dependency 'simplecov', '~> 0.9'
end
