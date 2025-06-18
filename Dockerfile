FROM node:22-slim

WORKDIR /app

# Install dependencies for development and Claude Code
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Install Docker's MCP toolkit (includes Git MCP)
RUN npm install -g @docker/mcp-toolkit

# Create claude config directory
RUN mkdir -p /root/.claude && chmod -R 777 /root/.claude

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Create .next directory with proper permissions
RUN mkdir -p .next && chmod -R 777 .next

# Copy MCP configuration (we'll create this next)
COPY claude-mcp-config.json /root/.claude/config.json

EXPOSE 3000

CMD ["npm", "run", "dev"]