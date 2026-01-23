FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache bash

COPY install.sh setup.sh start.sh ./
RUN chmod +x ./install.sh ./setup.sh ./start.sh

COPY --from=builder /app/node_modules ./node_modules
COPY src ./src
COPY package*.json ./
COPY .env_example ./
EXPOSE 3000
ENTRYPOINT ["/bin/bash", "-c", "if [ \"$SCRIPT_TYPE\" = \"setup\" ]; then \
  bash ./setup.sh; \
elif [ \"$SCRIPT_TYPE\" = \"git_install\" ]; then \
  bash ./install.sh; \
else \
  echo \"[ERROR] Invalid SCRIPT_TYPE: $SCRIPT_TYPE\"; \
  echo \"Valid values are: setup | git_install\"; \
  exit 1; \
fi"]
