# AI Invoice Frontend - Railway deploy
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
# Build-time: VITE_API_BASE_URL from Railway Variables (frontend service only)
ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL
RUN echo "VITE_API_BASE_URL=${VITE_API_BASE_URL}" > .env.production.local
RUN npm run build

# Serve with npx serve (respects PORT)
FROM node:20-alpine

WORKDIR /app
RUN npm install -g serve

COPY --from=builder /app/build ./build

EXPOSE 3000
CMD ["sh", "-c", "serve -s build -l ${PORT:-3000}"]
