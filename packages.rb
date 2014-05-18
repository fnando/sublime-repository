require 'json'

$packages = {
  'Better RSpec' => 'fnando/better-rspec-for-sublime-text',
  'Switch Case'  => 'fnando/sublime-switch-case',
  'Ansible' => 'clifford-github/sublime-ansible',
  'Highlight' => 'n1k0/SublimeHighlight',
  'Expand Selection to Quotes' => 'kek/sublime-expand-selection-to-quotes',
  'Autoprefixer' => 'sindresorhus/sublime-autoprefixer'
}

$payload = {
  schema_version: "2.0",
  packages: []
}

$packages.each do |name, gh|
  $payload[:packages] << {
    name: name,
    details: %[https://github.com/#{gh}],
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
