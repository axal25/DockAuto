# Git How To

`git clone https://github.com/axal25/DockAuto.git`
`add .`
`git commit -m 'msg'`
`git push -u origin master`

# Useful

1. Remove added to index file
`git rm path/to/file`
1. Reset git local to previous local commit
`git reset HEAD~`

# Troubles
1. Git push not working
    1. Trouble scenario  
    `$ git push -u origin master`  
    `error: src refspec master does not match any`
    `error: failed to push some refs to 'https://github.com/axal25/`DockAuto.git'`
    1. Fix
        1. Show references  
        `$ git show-ref`
        `17767a39e8f6779be8889c966c591078878e40ef refs/heads/main`
        `9cf3829b2d50636c2814b08b57c8c0893bfd3630 refs/remotes/origin/HEAD`
        `9cf3829b2d50636c2814b08b57c8c0893bfd3630 refs/remotes/origin/main`  
        1. Try pushing local HEAD ref to remote master ref  
        `git push origin HEAD:master`

