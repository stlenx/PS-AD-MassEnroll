# PS-AD-MassEnroll
Powershell script that automatically adds new users to active directory domain from a csv file

# Still not very dynamic

Once run it will ask for the path to the csv file to use.
With this new update some settings can be easily changed from the options.json file without touching the code. Options are:

### domain

> De domain we're creating the users in

### tld

> Top level domain in which the domain is in. example.**com**

### adpath

> Path to create the users in, it will still create OUs inside of it for each class and course.

As it is right now the file will need the same rows i have.

## School work

This is school work which is why it's so hard coded to work only with my particular csv file, i might come back and make it better.
