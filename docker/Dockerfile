###############################################################################
# Step 1 : Builder image
#
FROM node:10-alpine AS builder

# Define working directory and copy source
WORKDIR /home/node/app
COPY . .
# Install dependencies and build whatever you have to build 
# (babel, grunt, webpack, etc.)
RUN npm install && npm run build


###############################################################################
# Step 2 : Test image
#
# Use the builder image as base image
FROM builder as test
# Copy the test files
# COPY tests tests
# Override the NODE_ENV environment variable to 'dev', in order to get required test packages
# ENV NODE_ENV dev
# 1. Get test packages; AND
# 2. Install our test framework - mocha
# RUN npm update && \
#     npm install -g mocha
# Override the command, to run the test instead of the application
CMD ["npm", "test"]



###############################################################################
# Step 3 : Run image
#
FROM node:10-alpine
ENV NODE_ENV=production
WORKDIR /home/node/app

# Install deps for production only
COPY ./package* ./
RUN npm install && \
    npm cache clean --force
# Copy builded source from the upper builder stage
COPY --from=builder /home/node/app/build ./build

# Expose ports (for orchestrators and dynamic reverse proxies)
EXPOSE 3000

# Start the app
CMD npm start

