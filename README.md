This repo contain the blureprint solution for below - 

1. Docker Whale: Write a Dockerfile to run Energi Node in a container. It should somehow verify the checksum of the downloaded release (there's no need to build the project), run as a normal user, it should run the client, and print its output to the console.
https://wiki.energi.world/en/downloads/core-node
The build should be security conscious, and ideally pass a container image security test such as ECR, or Trivy.   --> Dockerfile 
[20 pts]
2. K8S Awesomeness: Write a Kubernetes StatefulSet to run the above, using persistent volume claims and resource limits. --> energi-statefulset.yml
[10 pts]
3. All the continuouses: Write a simple build and deployment pipeline for the above using groovy / Jenkinsfile, Travis CI or Gitlab CI.  --> Jenkinsfile
[15 pts]
4. Script kiddies: Source or come up with a text manipulation problem and solve it with at least two of awk, sed, tr. and / or grep. Check the question below first though, maybe.  --> programming
[10 pts]
5. Script grown-ups: Solve the problem in question 4 using any programming language of your choice.  --> programming
[15 pts]
6. Terraform lovers: write a Terraform module that creates the following resources in IAM:  --> iam.tf
● A role, with no permissions, which can be assumed by users within the same
account
● A policy, allowing users / entities to assume the above role
● A group, with the above policy attached
● A user, belonging to the above group
● All four entities should have the same name, or be similarly named in some
meaningful way given the context e.g. prod-ci-role, prod-ci-policy, prod-ci-group, prod-ci-user; or just prod-ci. Make the suffixes toggleable, if you wish.
