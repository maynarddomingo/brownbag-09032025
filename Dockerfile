FROM debian:bookworm-slim

# Install base tools
RUN apt-get update && apt-get install -y \
    bash curl unzip git python3 python3-pip less vim ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install AWS CLI v2
# -----------------------------
ENV AWSCLI_VERSION=2.17.9
RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli \
    && rm -rf aws awscliv2.zip

# -----------------------------
# Install kubectl
# -----------------------------
ENV KUBECTL_VERSION=v1.30.2
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# -----------------------------
# Install Terraform
# -----------------------------
ENV TERRAFORM_VERSION=1.9.5
RUN curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /workspace
