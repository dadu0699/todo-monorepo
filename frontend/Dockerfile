### STAGE 1: Build Angular app ###
FROM node:24-alpine AS build

# Enable corepack and pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

# Create non-root user
RUN adduser -D myuser

# Set working directory
WORKDIR /app

# Copy dependency definitions and lockfile
COPY package.json pnpm-lock.yaml ./

# Install dependencies (including dev for build)
RUN pnpm install --frozen-lockfile

# Copy the rest of the source code
COPY . .

# Build Angular app (default output: dist/frontend)
RUN pnpm run build --configuration=production

### STAGE 2: Serve with Nginx ###
FROM nginx:alpine

# Copy Angular build output
COPY --from=build /app/dist/frontend/browser /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
