# frozen_string_literal: true

require "json"
require "time"

packages = JSON.parse(File.read("#{__dir__}/packages.json"))

payload = {
  schema_version: "2.0",
  packages: []
}

packages.each do |name, info|
  repo = %[https://github.com/#{info['repo']}]

  payload[:packages] << {
    name: name,
    description: info["description"],
    details: repo,
    releases: [
      {
        sublime_text: "*",
        details: repo,
        branch: info["branch"]
      }
    ]
  }
end

File.open("public/repositories.json", "w") do |file|
  file << JSON.pretty_generate(payload)
end

built_on = Time.now.strftime("%FT%T%:z")
package_list_html = packages.map do |name, info|
  %[
    <li>
      <a href="https://github.com/#{info['repo']}">#{name}</a><br>
      #{info['description']}
    </li>
  ]
end.join("\n")

html = <<~HTML
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Custom Sublime Repository</title>
    <style type="text/css">
      :root {
        --color-background: #fff;
        --color-text: #222;
        --color-title: #000;
        --color-pre: #f0f0f0;
        --color-pre-text: #222;
        --color-link: #3d90d5;
      }

      @media screen and (prefers-color-scheme: dark) {
        :root {
          --color-background: #141a21;
          --color-text: rgba(255, 255, 255, .3);
          --color-title: #fff;
          --color-pre: rgba(255, 255, 255, .1);
          --color-pre-text: rgba(255, 255, 255, .6);
          --color-link: #3d90d5;
        }
      }

      html {
        background: var(--color-background);
      }

      h1 {
        color: var(--color-title);
      }

      body {
        color: var(--color-text);
        padding: 20px;
        max-width: 700px;
        margin: 0 auto;
        font-family: Menlo, monospace;
        font-size: 13px;
        line-height: 1.5;
      }

      pre {
        background: var(--color-pre);
        color: var(--color-pre-text);
        overflow: auto;
        padding: 15px;
      }

      a {
        color: var(--color-link);
      }

      li + li {
        margin-top: 15px;
      }
    </style>
  </head>
  <body>
    <h1>Sublime Text Repository</h1>
    <p>
      To install packages from this channel, just add it
      to <a href="https://packagecontrol.io">Package Control</a>.
    </p>

    <p>
      Enable the command palette and type 'Add Repository'. Then paste the
      following URL:
    </p>

    <pre><code id="repository"></code></pre>

    <p>
      Available packages:
    </p>

    <ul>
      #{package_list_html}
    </ul>

    <p>
      Page last built on #{built_on}.
    </p>

    <script>
      document.querySelector("#repository").textContent = location.protocol + "//" + location.hostname + "/repositories.json";
    </script>
  </body>
  </html>
HTML

File.open("public/index.html", "w") do |file|
  file << html
end
