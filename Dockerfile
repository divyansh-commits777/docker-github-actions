# Start from the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root user to install additional packages
USER root

# Install Jenkins plugins required for Octopus Deploy integration
RUN jenkins-plugin-cli --plugins \
    workflow-aggregator:2.6 \
    git:4.8.2 \
    octopusdeploy:3.1.6 \
    configuration-as-code:1.52

# Install Octopus CLI
RUN curl -L https://octopus.com/downloads/latest/OctopusCLI/linux-x64 -o octopuscli.tar.gz && \
    tar xzf octopuscli.tar.gz && \
    mv octo /usr/local/bin/octo && \
    chmod +x /usr/local/bin/octo && \
    rm octopuscli.tar.gz

# Set permissions for Jenkins user
RUN chown -R jenkins:jenkins /usr/local/bin/octo

# Switch back to Jenkins user
USER jenkins

