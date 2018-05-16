var presetOpts = {
  whatBump: function(commits) {
    var level = 2;
    var breakings = 0;
    var features = 0;

    commits.forEach(function(commit) {
      if (!commit.type) {
        return;
      }

      if (commit.type.toLowerCase() === 'breaking') {
        breakings += 1;
        level = 0;
      } else if (commit.type.toLowerCase() === 'new') {
        features += 1;
        if (level === 2) {
          level = 1;
        }
      }
    });

    return {
      level: level,
      reason: 'There are ' + breakings + ' breaking changes and ' + features + ' features'
    };
  },
  parserOpts: {
    headerPattern: /^(\w*): (.*)$/,
    headerCorrespondence: [
      'type',
      'subject'
    ],
    revertPattern: /^[rR]evert:\s([\s\S]*?)\s*This reverts commit (\w*)\./,
    revertCorrespondence: ['header', 'hash']
  }
};

module.exports = presetOpts;
