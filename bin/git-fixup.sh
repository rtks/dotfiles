#!/bin/bash

lastCommit=""
editorCmd="sed -i ''"
for commit in $@; do
  lastCommit=${commit:0:7}
  editorCmd="$editorCmd -e 's/pick ${lastCommit}/fixup ${lastCommit}/'"
done

GIT_SEQUENCE_EDITOR=$editorCmd git rebase -i ${lastCommit}~2
