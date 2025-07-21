# Industry Use Cases: Content Creation and Repository Overview

## Getting Started Walkthrough

This document serves as a comprehensive guide for content creators and team members getting up to speed with the Neo4j Industry Use Cases repository and content strategy.

## Overview and Focus

As a company, we aim to establish Neo4j as a leading graph authority in our respective industries. To achieve this, we must modify our approach to customer engagement. Along with our existing efforts, we should initiate conversations with business owners regarding their specific challenges and provide innovative solutions.

This website is designed to gather industry use cases, specifically emphasising the industry rather than Neo4j as a technology. When creating documentation, it is important to remember that our goal is to solve a business problem by discussing the problem itself and how to solve it.

We have a significant amount of excellent content that delves into the technical application of the stack, so we do not need to replicate it here.

## Tracking Industry Use Cases

In order to keep track of all the use cases, both those that have been created and those in the pipeline, the following sheet will be used:

**All Industry Use Cases**

This sheet also acts as a checklist for all things that need completing before any content is made live. These items include:

- Data Model Link
- Technical Use Case document
- SDR Outreach wording

This is really important as it is curated content the SDR team can use in lead generation via email or LinkedIn.

## Google Drive Folder Structure

The folder structure is important as it will ensure that documentation is easily managed and replicated onto the industry use cases website with ease. The structure is pretty simple:

### Root Directory
**Location:** Industry Use Cases Root Directory  
`/Industry Use Cases`

This holds all the industry folders where detailed use case information will be placed, e.g. Financial services, Insurance etc…

It also holds a document that is the landing page of the site: Neo4j Industry Use Cases Introduction

### Industry Folder
**Location:** Insurance  
`/Industry Use Cases/Insurance`

In the insurance industry and other sectors, there won't be any additional segregation of the folder structure. However, a further divide may occur in industries like financial services, such as the separation of retail banking and investment banking, which are two distinct fields.

In this folder, there will be two key things:
- An overview document that provides a high-level introduction to this industry e.g. Insurance Use Cases
- Numerous folders will hold the content for a single use case.

### Use Case Folder
**Location:** Quote Fraud  
`/Industry Use Cases/Insurance/Quote Fraud`

The main bulk of the content will be stored in the use case folder. Each folder will contain a minimum of:
- Data model diagram exported from arrows, e.g. Quote Fraud Arrows
- Use case write-up which contains 6 key sections e.g. Quote Fraud

## Use Case Content Structure

Each use case documentation should follow this 6-section structure:

### 1. Introduction
**What is the business problem we are to solve?**

This introduction is focused on the business use case. Please note that this documentation is less about Neo4j as a technology and more about how we solve business problems.

### 2. Scenario
**Why do businesses find themselves in this situation?**

### 3. Solution
This is where we can start to think a little about why Graph Databases are good at solving these problems.

### 4. Modelling
- Simple getting started data model which would have the minimum number of fields to solve this business problem.
- Also includes a quick description of each node/relationship and their properties
- This section also includes a simple import statement to allow people to insert some data to play with later on

### 5. Cypher Queries
Here we provide some example queries growing in complexity to illustrate exactly how we can solve this problem

### 6. GDS
If there are some GDS algorithms that would work well with this use case to add value, add them here.

## How to Publish to the Website

The publishing to the website happens via a GitHub repository, where we convert all the content curated in the Google documents and create the relevant markdown files. The GitHub repository is located here:

**https://github.com/neo4j-documentation/field-industry-use-cases**

You will see that the exact same folder structure inside of Google Drive is replicated in this repository:

**https://github.com/neo4j-documentation/field-industry-use-cases/tree/main/modules/ROOT/pages**

A branch needs to be created with all your new content and then a Pull Request needs to be created for review before content is merged into the main branch. Once the content is merged a manual trigger (soon to be automated) deploys the code to the website.

## Repository Access

For access to this repository, please speak to:

- **J Barrasa** - jesus.barrasa@neo4j.com
- **Michael Down** - michael.down@neo4j.com

## Content Philosophy

Remember: **Focus on solving business problems, not showcasing technology.**

- Emphasize the industry and business problem, not the technology
- Focus on how to solve real business challenges using graph thinking
- Avoid replicating technical Neo4j documentation that exists elsewhere
- Establish Neo4j as a graph authority by addressing specific industry challenges