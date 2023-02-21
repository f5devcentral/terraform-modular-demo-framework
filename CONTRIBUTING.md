## Introduction
The purpose of this repository is to make it ridiculously easy for Solution Engineers and Customers to try the capabilities of F5's portfolio of products and services, grounded with F5 Distrubuted Cloud(XC). 

## How to Contribute
There are a variety of valuable ways in which you can contribute to this project.
### Bug Reports
If you encounter an error, creating an issue in the repository is of great help.
Please include the following with your error description:
- the command you ran prior to the error
- the output of `git log -1 --oneline` (note: that's a number one, not a lowercase L)
### Documentation Improvements
Any documentation improvements are valuable to the project.
- editing existing documentation for clarity and readability
- creating new documentation where gaps exist
### Feature Requests
When requesting new feature, please try to describe the behavior the solution would exhibit or the tasks/activities you would be able to perform if the feature was implemented.
### Code 
#### Standards
We should have, but don't currently have, standards for intermodule communications (variables and outputs).
##### semantic versioning
No module or orchestration should be tagged with v1.x until there is collective agreement that it is ready to be promoted to the community repository.
#### Refactoring the main repository
at a minimum work from a feature branch.
if you're working on something that doesn't have an associated issue, please create the issue first.
#### Refactoring existing modules
at a minimum work from a feature branch.
if you're working on something that doesn't have an associated issue, please create the issue first.
#### Creating new modules
use the standards
For expediency, you should build the first version of your module within the main repository on a feature branch. Once your module code is reasonably mature
- create a module repository
- move your module code into it
- update the `terragrunt.hcl` file, pointing to the repository as source
## Code of Conduct
Be nice
## Contact Information
Us