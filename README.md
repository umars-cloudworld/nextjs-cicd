## Contributors
- Muhammad Umar (Host)
# Project-2 - Secure Next.js Web App Deployment on AWS ECS using Terraform and GitHub Actions
#  Author: Muhammad Umar                                        
#  Email : m.umerpervaiz@gmail.com     
![Nextjs Deployment](Project-2.jpg)
                     
Deployed a secure Next.js web app on AWS ECS using Terraform for infrastructure setup. Strengthened 
security through IAM, Security Groups, and a well-architected VPC. Implemented efficient CI/CD using 
GitHub Actions, ensuring automated testing and deployment. Integrated ALB for optimal traffic 
management, providing a seamless user experience.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)


## Prerequisites

Before getting started, ensure you have the following prerequisites:

- AWS account with appropriate permissions
## Usage
Steps to follow for full CI CD deployment on ECS:
1. Create your infrastructure using terraform
    * Setup terraform remote state using provided backend folder
    * Copy all the content from 1st.yml and paste it into the aws.yml file which resides in .github/workflows/

2. Run below command to get the task-definition details in json format
```sh
    aws ecs describe-task-definition \
    --task-definition "nextjs-task-def" \
    --query taskDefinition > .github/workflows/task-definition.json
```
 
3. Make 2 changes in task-definition.json
    1st - "taskDefinitionArn" remove colon and revision number
    2nd - At line number 30 remove revision number as well.

4. Create 2 secrets in github repository, with same names as below and fill the values.
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
5. Copy all the content from 3rd.yml and paste it into the aws.yml file which resides in .github/workflows/

6. Keep everything as it is in aws.yml file expect, after first successfully deployment
    change "wait-for-service-stability: false" to true.

7. Congrates on successfull deployment, Keep doing well!!!

## Contributing

Contributions are welcome! If you find any issues or have improvements to suggest, feel free to open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries or questions, please contact me

                                                HAPPY LEARNING :)