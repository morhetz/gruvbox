## Commit Guidelines

Commit messages should describe what changed, and reference the issue number if the commit closes or is associated with a particular issue. Commit messages for all jQuery projects should look like this:

```
Component: Short Description

Optional Long Description

Fixes #xxx
Closes gh-yyy
Ref #zzz
```

Every commit must have a subject (the first line). Everything else is optional.

### Subject

This is the first line. It consists of a component, like "Event" or "Autocomplete". This line must be 72 characters or less. There should be no full stop (period) at the end.

### Long description

There are two line breaks between the subject and the long description. The description can have any length and formatting, like lists, but it must be hard-wrapped at 80 characters.

### References

References to issues or pull requests go after the long description, each one on their own line.

* Use **Fixes** when the commit fixes an open issue.

* Use **Closes** when the commit closes an open pull request.

* Use **Ref** when referencing an issue or pull request that is already closed or should remain open. Examples include partial fixes and commits that add a test but not a fix.

* Always use "gh-xxx" for GitHub issues and pull requests within the same repository. Use "\[user\]/\[repo\]#xxx" when referencing an issue or pull request in another repository, e.g., "Closes jquery/jquery-ui#175".

Based on https://github.com/jquery/contribute.jquery.org/blob/master/pages/commits-and-pull-requests.md#commit-guidelines
