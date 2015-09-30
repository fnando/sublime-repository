require 'json'

$packages = {
  'Better Ruby' => 'fnando/better-ruby-for-sublime-text',
  'Better RSpec' => 'fnando/better-rspec-for-sublime-text',
  'Better Rails' => 'fnando/better-rails-for-sublime-text',
  'Better QUnit' => 'fnando/better-qunit-for-sublime-text',
  'Switch Case'  => 'fnando/sublime-switch-case',
  'Ansible' => 'clifford-github/sublime-ansible',
  'Highlight' => 'n1k0/SublimeHighlight/tree/python3',
  'Expand Selection to Quotes' => 'kek/sublime-expand-selection-to-quotes',
  'Autoprefixer' => 'sindresorhus/sublime-autoprefixer',
  'Theme - El Capitan' => 'iccir/El-Capitan-Theme',
}

$payload = {
  schema_version: "2.0",
  packages: []
}

$packages.each do |name, gh|
  $payload[:packages] << {
    name: name,
    details: %[https://github.com/#{gh.split('/')[0,2].join('/')}],
    releases: [
      {
        sublime_text: '*',
        details: %[https://github.com/#{gh}]
      }
    ]
  }
end

File.open('repositories.json', 'w') do |file|
  file << JSON.pretty_generate($payload)
end
