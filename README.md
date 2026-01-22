# DevOps Candidate Challenge

## Your Tasks

### 1. Setup and Launch

Run the app using the provided scripts:

```bash
chmod +x setup.sh start.sh
./setup.sh
./start.sh
```

Ensure you configure `.env` from `.env_example`.

#### Development

- Run in Dev Mode

```bash
npm install
npm run dev
```

- Build and Run

```bash
npm start
```

### 2. Improve Shell Scripts

Refactor and harden:

- `install.sh`, `setup.sh`: Validate environment, improve logging
- `start.sh`: Add safety features, background tasks, or monitoring

### 3. Containerize the Application

- Create a `Dockerfile` to run `app.js`
- Optional: Add `docker-compose.yml` for easier orchestration
- Ensure logs persist and `.env` can be injected cleanly

### 4. Create a GitHub Actions workflow that:

- Triggers on push events on the main branch
- Builds a Docker image of the project
- Tags the image using the current Git commit SHA
- (Optional) Pushes the image to a container registry (e.g., Docker Hub or GitHub Container Registry)

---

## Project Structure

```
test-devops-orchestrators/
├── setup.sh           # Setup script
├── start.sh           # Starts app.js and api.js
├── install.sh         # Installation script to set up and run on the client node
├── .env_example       # Set your INFURA_URL here
├── package.json
└── src/
    └── app.js          # Express server on port 3000

```

---

## Requirements

- Node.js 18+
- Bash (for script execution)

---
