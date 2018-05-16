'use strict'

var reNomatch = /(?!.*)/

function join (array, joiner) {
  return array
    .map(function (val) {
      return val.trim()
    })
    .filter(function (val) {
      return val.length
    })
    .join(joiner)
}

function getNotesRegex (noteKeywords) {
  if (!noteKeywords) {
    return reNomatch
  }

  return new RegExp('^[\\s|*]*(' + join(noteKeywords, '|') + ')[:\\s]+(.*)', 'i')
}

function getReferencePartsRegex (issuePrefixes) {
  if (!issuePrefixes) {
    return reNomatch
  }

  return new RegExp('(?:.*?)??\\s*([\\w-\\.\\/]*?)??(' + join(issuePrefixes, '|') + ')([\\w-]*\\d+)', 'gi')
}

function getReferencesRegex (referenceActions) {
  if (!referenceActions) {
    // matches everything
    return /()(.+)/gi
  }

  var joinedKeywords = join(referenceActions, '|')
  return new RegExp('(' + joinedKeywords + ')(?:\\s+(.*?))(?=(?:' + joinedKeywords + ')|$)', 'gi')
}

module.exports = function (options) {
  options = options || {}
  var reNotes = getNotesRegex(options.noteKeywords)
  var reReferenceParts = getReferencePartsRegex(options.issuePrefixes)
  var reReferences = getReferencesRegex(options.referenceActions)

  return {
    notes: reNotes,
    referenceParts: reReferenceParts,
    references: reReferences,
    mentions: /@([\w-]+)/g
  }
}
