require "json"

packages = {
  "Ansible"                    => {repo: "clifford-github/sublime-ansible", branch: "master"},
  "Autoprefixer"               => {repo: "sindresorhus/sublime-autoprefixer", branch: "master"},
  "Better QUnit"               => {repo: "fnando/better-qunit-for-sublime-text", branch: "master"},
  "Better Rails"               => {repo: "fnando/better-rails-for-sublime-text", branch: "master"},
  "Better RSpec"               => {repo: "fnando/better-rspec-for-sublime-text", branch: "master"},
  "Better Ruby"                => {repo: "fnando/better-ruby-for-sublime-text", branch: "master"},
  "Expand Selection to Quotes" => {repo: "kek/sublime-expand-selection-to-quotes", branch: "master"},
  "Highlight"                  => {repo: "n1k0/SublimeHighlight/tree/python3", branch: "master"},
  "Switch Case"                => {repo: "fnando/sublime-switch-case", branch: "master"},
  "Theme - El Capitan"         => {repo: "iccir/El-Capitan-Theme", branch: "master"}
}

payload = {
  schema_version: "2.0",
  packages: []
}

packages.each do |name, info|
  repo = info[:repo].split("/")[0, 2].join("/")

  payload[:packages] << {
    name: name,
    details: %[https://github.com/#{repo}],
    releases: [
      {
        sublime_text: "*",
        details: %[https://github.com/#{info[:repo]}],
        branch: info[:branch]
      }
    ]
  }
end

File.open("repositories.json", "w") do |file|
  file << JSON.pretty_generate(payload)
end
