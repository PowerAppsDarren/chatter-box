# Copilot Instructions

## Logging of all AI Assistance

This project maintains thorough documentation of all AI assistance. 
When generating code or providing suggestions, please be aware of the following:

- All our Copilot conversations are documented in `ai-chats/yyyy-mm-dd-hhmm-brief-description/` folders  (make the hh 24-hour format)
- Brief-description is a short summary of the conversation. Only use two words so that the folder doesn't become too long.
- Each conversation exchange is stored in numbered markdown files (e.g., `01-initial-setup.md`)
- Within each file created, put a date/time stamp at the top of the file in the format YYYY-MM-DD HH:MM:SS (Timezone)
- Each time I respond or prompt you in a chat should trigger a new file in that folder. 
- Our documentation structure is critical for maintaining project history and decision tracking
- We follow a strict documentation format with separate sections for prompts and responses

## Code Comments 

- Always write comments in English.
- Use clear and concise language.
- Avoid using jargon or abbreviations that may not be universally understood.
- Use complete sentences and proper grammar.
- Use comments to explain the "why" behind complex logic or decisions.
- Avoid stating the obvious; focus on providing context or rationale for the code.
- Use TODO comments to indicate areas for future improvement or refactoring.

## Coding Conventions

- We write JavaScript with double quotes and tabs for indentation.
- We use camelCase for variables and PascalCase for class names.
- Always include JSDoc comments for all functions and methods.
- Prefer arrow functions over traditional function declarations.
- For CSS, we follow BEM methodology for naming classes.

## Technology Context

- Frontend: React, NextJS, TypeScript, Tailwind CSS, Headless UI, ShadCN
- Backend: Node.js, Express, NestJS, TypeScript
- Relational Database: PostgreSQL, Prisma
- Graph Database: Neo4j
- Testing: Jest, React Testing Library, Cypress
- CI/CD: GitHub Actions
- Linting: ESLint, Prettier
- Version Control: Git
- Documentation: Markdown
- DevOps & Deployment
  - Docker
  - Kubernetes
- Data Visualization: sigma.js, D3.js, Cytoscape.js, Chart.js, Plotly.js

## Project Organization

- All React components should be in separate files with the same name as the component.
- API routes go in the /api directory with RESTful naming conventions.
- Utility functions should be placed in /utils with descriptive filenames.
- Always create unit tests in a __tests__ folder adjacent to the tested file.

## Time Awareness

This project includes an automatic time update system that provides GitHub Copilot with accurate time information:

- Current time information is stored in `Resources-for-AI/current_time.md`
- The file is automatically updated when engaging with AI tools via:
  - VS Code extension: `src/ai-time-updater`
  - VS Code task: "Update Current Time"
  - npm script: `npm run update-time`
- When asked about the current time, check the most recent time information in the file
- If necessary, run the "Update Current Time" task to refresh the time information
- Time format follows: YYYY-MM-DD HH:MM:SS (Timezone)
- The time system is documented in `ai-chats/2025-05-17-automatic-time-script-configuration`
