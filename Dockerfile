FROM node:22-slim

WORKDIR /app

# Install dependencies for development and Claude Code
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code only
RUN npm install -g @anthropic-ai/claude-code

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

EXPOSE 3000

CMD ["npm", "run", "dev"]