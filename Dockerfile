FROM node:20-alpine AS stage0

WORKDIR /workspace

COPY ./ ./

RUN npm ci && npm run build && rm -rf node_modules && npm ci --omit=dev && npm cache clean --force

FROM node:20-alpine

WORKDIR /workspace

COPY --from=stage0 ./workspace .

EXPOSE 3000
CMD ["npm", "start"]
