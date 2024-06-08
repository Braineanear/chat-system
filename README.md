Chat System

Overview
This project implements a chat system using Ruby on Rails, MySQL, Redis, and ElasticSearch. The system allows creating applications with unique tokens, managing chats within applications, and handling messages within chats. It supports search functionality for messages using ElasticSearch and ensures concurrency handling through background jobs with Sidekiq.

Prerequisites
- Docker
- Docker Compose

Setup

1. Clone the repository:

   First, clone the repository from the source control and navigate into the project directory.

    ```sh
    git clone <repository-url>
    cd chat_system
    ```

2. Install dependencies:

   Ensure Docker and Docker Compose are installed on your machine. Then, use Docker Compose to build and start all necessary services, including MySQL, Redis, ElasticSearch, and the Rails application.

    ```sh
    docker-compose up
    ```

Usage

Endpoints

- **Applications**
  - Create a new application:
    - `POST /applications`
    - Request body: `{ "name": "ApplicationName" }`
    - Response: `{ "token": "generated_token" }`

  - List all applications:
    - `GET /applications`
    - Response: `[ { "name": "ApplicationName", "token": "generated_token", "chats_count": 0 } ]`

  - Get a specific application:
    - `GET /applications/:token`
    - Response: `{ "name": "ApplicationName", "token": "generated_token", "chats_count": 0 }`

  - Update an application:
    - `PATCH /applications/:token`
    - Request body: `{ "name": "NewApplicationName" }`
    - Response: `{ "name": "NewApplicationName", "token": "generated_token", "chats_count": 0 }`

- **Chats**
  - Create a new chat within an application:
    - `POST /applications/:token/chats`
    - Response: `{ "number": 1 }`

  - List all chats for an application:
    - `GET /applications/:token/chats`
    - Response: `[ { "number": 1, "messages_count": 0 } ]`

  - Get a specific chat:
    - `GET /applications/:token/chats/:id`
    - Response: `{ "number": 1, "messages_count": 0 }`

- **Messages**
  - Create a new message within a chat:
    - `POST /applications/:token/chats/:chat_id/messages`
    - Request body: `{ "body": "Message body" }`
    - Response: `{ "number": 1 }`

  - List all messages for a chat:
    - `GET /applications/:token/chats/:chat_id/messages`
    - Response: `[ { "number": 1, "body": "Message body" } ]`

  - Get a specific message:
    - `GET /applications/:token/chats/:chat_id/messages/:id`
    - Response: `{ "number": 1, "body": "Message body" }`

  - Search messages in a chat:
    - `GET /chats/:chat_id/messages/search?q=keyword`
    - Response: `[ { "number": 1, "body": "Message body" } ]`

Implementation Details

Models

- Application
  - An application has a name and a unique token. It also tracks the number of chats associated with it.
  - It has many chats associated with it.

- Chat
  - A chat belongs to an application and has a unique number within that application. It also tracks the number of messages associated with it.
  - It has many messages associated with it.

- Message
  - A message belongs to a chat and has a unique number within that chat. It contains the body of the message.
  - Messages are indexed using ElasticSearch for search functionality.

Controllers

- ApplicationsController
  - Manages creating, updating, and retrieving applications.

- ChatsController
  - Manages creating and retrieving chats within an application.

- MessagesController
  - Manages creating and retrieving messages within a chat and searching through messages.

Background Jobs

- CreateChatJob
  - Handles the creation of chats in the background to ensure concurrency handling.

- CreateMessageJob
  - Handles the creation of messages in the background to ensure concurrency handling.

Configuration Files

- wait-for-it.sh
  - A script to ensure that the necessary services (MySQL, Redis, ElasticSearch) are available before starting the Rails application.
