# ShelOS 1.0                                  shelcorp 2025
# =========================================================

    1. Introduction
    2. Features
        a. Tools
        b. Integrations
        c. Workflows
    3. Installation
    4. Configuration
    5. Usage
        a. Basic Commands
        b. Advanced Commands
    6. Contributing
    7. License

## Introduction
Welcome to ShelOS 1.0.


## Features
### Tools
Packed with tools like `nvim` and `git` to boost productivity.

### Integrations
Connect with modern services like GitHub and Jira seamlessly.

### Workflows
Pre-configured workflows for project management and coding.

## Installation
1. Clone the repository:
    ```
    git clone https://github.com/shelcorp/shelos.git
    ```
2. Navigate to the `bin` directory:
    ```
    cd shelos/bin
    ```
3. Run the installation script:
    ```
    ./install.sh
    ```

## Configuration
Edit the `.conf.yaml` file to set preferences and API keys:
```yaml
- jira:
    - username: $JIRA_USERNAME
    - key: $JIRA_API_TOKEN
- gh:
    - username: $GITHUB_USERNAME
    - key: $GITHUB_API_TOKEN
```

## Usage
### Basic Commands
- Check system health:
    ```
    ./healthcheck.sh
    ```
- List available scripts:
    ```
    ./dfm.sh
    ```

### Advanced Commands
- Run a specific function from a script:
    ```
    ./bin/utils/function_runner.sh <script-file> <function-name>
    ```

## Contributing
Fork the repository, make changes, and submit a pull request.

## License
ShelOS is licensed under the MIT License. See the LICENSE file for details.

Thank you for choosing ShelOS.
