# frozen_string_literal: true

require "json"

packages = {
  "Autoprefixer" => {repo: "sindresorhus/sublime-autoprefixer", branch: "master", details: "Sublime plugin to prefix your CSS"},
  "Better QUnit" => {repo: "fnando/better-qunit-for-sublime-text", branch: "master", details: "A custom QUnit package, that includes snippets, custom syntax highlighters and more!"},
  "Better Rails" => {repo: "fnando/better-rails-for-sublime-text", branch: "master", details: "A custom Rails package, that includes snippets, custom syntax highlighters and more!"},
  "Better RSpec" => {repo: "fnando/better-rspec-for-sublime-text", branch: "master", details: "A custom RSpec package, that includes snippets, custom syntax highlighters and more!"},
  "Better Ruby" => {repo: "fnando/better-ruby-for-sublime-text", branch: "master", details: "A custom Ruby package, that includes snippets, custom syntax highlighters and more!"},
  "Expand Selection to Quotes" => {repo: "kek/sublime-expand-selection-to-quotes", branch: "master", details: "Sublime Text plugin to expand selection to surrounding quotes"},
  "Name That Color" => {repo: "fnando/sublime-name-that-color", branch: "master", details: "Fetch the color name for hexdecimal RGBs from different sources."},
  "Switch Case" => {repo: "fnando/sublime-switch-case", branch: "master", details: "Alternate between different cases (snake_case, SCREAM_SNAKE_CASE, CamelCase, camelBack, and hyphenate)"}
}

payload = {
  schema_version: "2.0",
  packages: []
}

packages.each do |name, info|
  repo = info[:repo].split("/")[0, 2].join("/")

  payload[:packages] << {
    name: name,
    details: info[:details],
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
