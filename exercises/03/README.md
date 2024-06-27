# Lab 3 : Data Sources

In this lab you have several items:

- A `providers.tf` file
- A `variables.tf` variable file
- A `locals.tf` locals file

This lab is for you to exercise querying the state with data sources in order to create an ec2-instance

* Create a `aws_instance` considering:

   * It uses locals to compute random namings for resources that need to have globally unique names
   * Fetches via a data source the `ami` 
   
1. Create the `main.tf` configuration to create the ec2-instance
   
2. Apply.
   
3. Don't forget to delete the environment!

```
terraform destroy -auto-approve
```
