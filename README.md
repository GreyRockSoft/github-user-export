user-export
===========

The github-user-export tool is intended to help with administering users that belong within teams in organizations.  The main motifivation is to use this to make it 'easy' to get user data in a common file format for auditing who is in easy organization.

To use this, you must setup a `~/.netrc` as described here in the [https://github.com/octokit/octokit.rb#using-a-netrc-file](Octokit) documentation.  Once the netrc file is setup then you can begin to use the export tool to list teams that belong to an organization, and then list the users that are in a team.
