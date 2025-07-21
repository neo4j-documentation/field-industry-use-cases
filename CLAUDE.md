# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neo4j documentation project for industry use cases, built using Antora. The repository contains documentation for financial services, insurance, and agnostic graph database use cases and data models.

## Architecture

- **Documentation Framework**: Antora-based static site generator
- **Content Structure**: AsciiDoc files organized in modules/ROOT/pages/
- **Build System**: Node.js with npm scripts
- **Content Organization**:
  - `finserv/` - Financial services use cases (fraud detection, compliance, etc.)
  - `insurance/` - Insurance industry use cases (claims fraud, quote fraud)
  - `agnostic/` - Industry-agnostic patterns (entity resolution, IT service graphs)
  - `data-models/` - Reusable data model documentation

## Common Commands

### Development
- `npm start` - Start development server with live reload on port 8000
- `npm run build` - Build the site using Antora
- `npm run serve` - Serve the built site on localhost:8000
- `npm run adoc-gen` - Generate skeleton AsciiDoc files from navigation

### Build Verification
- `npm run build-verify` - Build with detailed logging for CI/CD
- `npm run publish-verify` - Verify publish configuration

## Content Structure

The main content is located in `modules/ROOT/pages/` with the following structure:
- Navigation defined in `modules/ROOT/content-nav.adoc`
- Images stored in `modules/ROOT/images/` organized by industry
- Page content uses AsciiDoc format (.adoc files)
- Reusable content in `modules/ROOT/partials/`

## Configuration Files

- `antora.yml` - Component configuration (name: industry-use-cases)
- `preview.yml` - Antora playbook for local development
- `publish.yml` - Antora playbook for production builds
- `server.js` - Local development server

## Content Guidelines

- All content files use AsciiDoc format
- Images should be SVG format when possible for data models and schemas
- Follow the existing directory structure when adding new use cases
- Use the content navigation file to register new pages

## Content Creation Guidelines

When creating new industry use case pages, focus on solving business problems rather than showcasing Neo4j as a technology. The goal is to establish Neo4j as a graph authority by addressing specific industry challenges.

### Content Philosophy
- Emphasize the industry and business problem, not the technology
- Focus on how to solve real business challenges using graph thinking
- Avoid replicating technical Neo4j documentation that exists elsewhere

### Use Case Structure
Each use case page should follow this 6-section structure:

1. **Introduction**
   - Define the business problem to be solved
   - Focus on the business context, not technology

2. **Scenario** 
   - Explain why businesses find themselves facing this problem
   - Provide context for when this situation typically occurs

3. **Solution**
   - Introduce why graph databases excel at solving this type of problem
   - Connect graph concepts to the business challenge

4. **Modelling**
   - Present a simple data model with minimum fields needed to solve the problem
   - Include descriptions of each node, relationship, and their properties
   - Provide import statements for sample data

5. **Cypher Queries**
   - Provide example queries of increasing complexity
   - Demonstrate how to solve the business problem step-by-step

6. **GDS (Graph Data Science)**
   - Include relevant GDS algorithms that add value to this use case
   - Show how advanced analytics can enhance the solution

### Required Assets
Each use case should include:
- Data model diagram (preferably exported from Arrows)
- Complete use case documentation following the 6-section structure
- SDR outreach content for lead generation purposes