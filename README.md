# Cooking Recipes Web App - Infrastructure as Code (IaC)

This repository contains the Infrastructure as Code (IaC) configuration files for deploying and managing the Cooking Recipes Web App. The infrastructure is designed to be modular and scalable, supporting both development and production environments.

## Table of Contents

- [About the Project](#about-the-project)
- [Infrastructure Overview](#infrastructure-overview)
- [Files and Directories](#files-and-directories)
- [Deployment Environments](#deployment-environments)
- [CI/CD Integration](#cicd-integration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About the Project

The IaC repository is responsible for automating the provisioning and management of all cloud resources required for the Cooking Recipes Web App. This includes setting up the networking, compute, storage, and security components needed to run the application in the cloud.

## Infrastructure Overview

The infrastructure is defined using Bicep, a domain-specific language (DSL) for deploying Azure resources declaratively. The main components of the infrastructure include:

- **Virtual Networks (VNets)**: For secure communication between application components.
- **Azure App Services**: Hosting the frontend and backend applications.
- **Azure SQL Database**: For storing recipe data securely.
- **Azure Key Vault**: For managing secrets and application settings.
- **Azure Storage Account**: For storing static files, such as images of recipes.

## Files and Directories

- **`main.bicep`**: The main Bicep file that orchestrates the deployment of all resources.
- **`modules/`**: Contains reusable Bicep modules, such as `appStuff.bicep`, that encapsulate specific components (e.g., App Services).
- **`dev.parameters.json`**: Parameter file for the development environment.
- **`prod.parameters.json`**: Parameter file for the production environment.
- **`.github/workflows/jrubiales-iac.yml`**: GitHub Actions workflow file for automating deployments.

## Deployment Environments

This repository supports multiple deployment environments, each with its own configuration:

- **Development Environment**: A lower-cost environment used for testing and development. Deployed using `dev.parameters.json`.
- **Production Environment**: A robust and secure environment optimized for high availability and performance. Deployed using `prod.parameters.json`.

## CI/CD Integration

The repository is integrated with GitHub Actions to enable continuous integration and continuous deployment (CI/CD) of infrastructure changes. The workflow:

1. **Triggers**: Runs automatically on commits to the `main` branch or manual triggers.
2. **Validation**: Validates Bicep templates and checks for syntax errors.
3. **Deployment**: Deploys the infrastructure changes to the specified environment (development or production).

## Usage

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your_username/cooking-recipes-web-app-iac.git
    ```
2. **Modify parameters**:
    - Update `dev.parameters.json` or `prod.parameters.json` with environment-specific values.
3. **Deploy infrastructure**:
    - Manually run the Bicep templates:
    ```bash
    az deployment group create --resource-group <your_resource_group> --template-file main.bicep --parameters @dev.parameters.json
    ```
    - Alternatively, push changes to the `main` branch to trigger the GitHub Actions workflow.

## Contributing

Contributions to improve or extend the infrastructure are welcome. Please adhere to the following process:

1. **Fork the repository** and create your feature branch (`git checkout -b feature/AmazingFeature`).
2. **Commit your changes** (`git commit -m 'Add some AmazingFeature'`).
3. **Push to the branch** (`git push origin feature/AmazingFeature`).
4. **Open a Pull Request** to the `main` branch.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Juan J. Rubiales - [jrubialesv@gmail.com](mailto:jrubialesv@gmail.com)

Project Frontend Link: [https://github.com/jrubialesv/cooking-recipes-web-app-frontend](https://github.com/jrubialesv/cooking-recipes-web-app-frontend)
Project Backend Link: [https://github.com/jrubialesv/cooking-recipes-web-app-backend](https://github.com/jrubialesv/cooking-recipes-web-app-backend)
Project IaC Link: [https://github.com/jrubialesv/cooking-recipes-web-app-iac](https://github.com/jrubialesv/cooking-recipes-web-app-iac)
