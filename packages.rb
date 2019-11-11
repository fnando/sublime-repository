# frozen_string_literal: true

require "json"

packages = JSON.parse(File.read("#{__dir__}/packages.json"))

payload = {
  schema_version: "2.0",
  packages: []
}

packages.each do |name, info|
  payload[:packages] << {
    name: name,
    details: info["details"],
    releases: [
      {
        sublime_text: "*",
        details: %[https://github.com/#{info['repo']}],
        branch: info["branch"]
      }
    ]
  }
end

File.open("repositories.json", "w") do |file|
  file << JSON.pretty_generate(payload)
end
