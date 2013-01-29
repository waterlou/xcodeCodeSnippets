#!/usr/bin/env coffee

# usage: makedoc.coffee > README.md

fs    = require 'fs'
plist = require 'plist'

# read every .codesnippet

data = {}

fs.readdir '.', (err, list) ->
  regex = /\.codesnippet$/
  list.forEach (file) ->
    stat = fs.statSync file
    if stat and file.match(regex) and stat.isFile()
      try
        obj = plist.parseFileSync(file)
        category = obj.IDECodeSnippetTitle.split(' ')[0]
        arr = data[category] or []
        arr.push obj
        data[category] = arr
      catch err
        ; #console.log err

  # output
  keys = Object.keys(data)
  keys.sort()
  for key in keys
    category = data[key]
    category.sort (a,b) ->
      return a.IDECodeSnippetCompletionPrefix > b.IDECodeSnippetCompletionPrefix
    console.log "# #{key}"
    for i in category
      console.log "### #{i.IDECodeSnippetCompletionPrefix}"
      console.log i.IDECodeSnippetSummary or i.IDECodeSnippetTitle
      content = i.IDECodeSnippetContents
      console.log ""
      for line in content.split("\n")
        console.log "        #{line}"
      console.log ""
      
